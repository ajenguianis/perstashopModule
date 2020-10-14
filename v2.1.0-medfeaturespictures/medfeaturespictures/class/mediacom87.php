<?php
/**
 * 2008-today Mediacom87
 *
 * NOTICE OF LICENSE
 *
 * Read in the module
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    Mediacom87 <support@mediacom87.net>
 * @copyright 2008-today Mediacom87
 * @license   define in the module
 * @version 1.0.0
 */

class MedFeaturesPicturesClass
{
    public function __construct($module)
    {
        $this->module = $module;
    }

    public function isoCode($domain = false)
    {
        $iso = $this->module->context->language->iso_code;

        if ($iso == 'fr') {
            return 'fr';
        } elseif ($domain) {
            return 'com';
        } else {
            return 'en';
        }
    }

    public function medJsonModuleFile()
    {
        $conf = Configuration::getMultiple(array('MED_JSON_TIME', 'MED_JSON_FILE'));

        if (!isset($conf['MED_JSON_TIME']) || $conf['MED_JSON_TIME'] < (time() - 604800)) {
            Configuration::updateValue('MED_JSON_TIME', time());
            $url_api = 'https://api-addons.prestashop.com/'
                ._PS_VERSION_.'/contributor/all_products/'
                .$this->module->module_key.'/'
                .$this->module->context->language->iso_code.'/'
                .$this->module->context->country->iso_code;
            $conf['MED_JSON_FILE'] = Tools::file_get_contents($url_api);
            Configuration::updateValue('MED_JSON_FILE', $conf['MED_JSON_FILE']);
        }

        $modules = Tools::jsonDecode($conf['MED_JSON_FILE'], true);

        if (!is_array($modules) || isset($modules['errors'])) {
            Configuration::updateGlobalValue('MED_JSON_TIME', 0);
            return null;
        } else {
            return $modules;
        }
    }

    public function medJsonModuleRate($id = false, $hash = false)
    {
        if (!$id || !$hash) {
            return null;
        }

        $conf = Tools::jsonDecode(Configuration::get('MED_A_'.$id), true);

        if (!isset($conf['time']) || $conf['time'] < (time() - 604800)) {
            $conf['time'] = time();
            $iso = $this->module->context->language->iso_code;
            $country = $this->module->context->country->iso_code;
            $url_api = 'https://api-addons.prestashop.com/'
                ._PS_VERSION_.'/contributor/product/'
                .$hash.'/'
                .$iso.'/'
                .$country;
            $result = Tools::file_get_contents($url_api);
            $module = Tools::jsonDecode($result, true);
            if (isset($module['products'][0]['nbRates'])) {
                $conf['nbRates'] = $module['products'][0]['nbRates'];
                $conf['avgRate'] = $module['products'][0]['avgRate']*2*10;
                $datas = Tools::jsonEncode($conf);
                Configuration::updateGlobalValue('MED_A_'.$id, $datas);
            } else {
                $conf = null;
            }
        }

        if (!is_array($conf)) {
            Configuration::deleteByName('MED_A_'.$id);
            return null;
        } else {
            return $conf;
        }
    }

    public function medGenerateCSS()
    {
        $this->module->context->smarty->assign(array(
            'config' => $this->module->conf,
        ));
        $css_name = 'style-'.time().'.css';
        $css_path = $this->module->tpl_path.'/views/css/';
        $content = Media::minifyCSS(
            $this->module->context->smarty->fetch(
                $this->module->tpl_path.'/views/templates/front.css.tpl'
            )
        );

        if (Tools::isEmpty($content)) {
            $this->medDeleteFile($css_path.$this->module->conf['css_name']);
            return true;
        } else {
            if (file_put_contents($css_path.$css_name, $content)) {
                if (isset($this->module->conf['css_name']) && $this->module->conf['css_name']) {
                    $this->medDeleteFile($css_path.$this->module->conf['css_name']);
                }
                return $css_name;
            } else {
                return false;
            }
        }
    }

    public function medGenerateJS($module_file)
    {
        $this->module->context->smarty->assign(array(
            'config' => $this->module->conf,
        ));
        $js_name = 'script-'.time().'.js';
        $js_path = $this->module->tpl_path.'/views/js/';
        $content = Media::packJS(
            $this->module->display(
                $module_file,
                'views/templates/front.js.tpl'
            )
        );

        if (Tools::isEmpty($content)) {
            $this->medDeleteFile($js_path.$this->module->conf['js_name']);
            return true;
        } else {
            if (file_put_contents($js_path.$js_name, $content)) {
                if (isset($this->module->conf['js_name']) && $this->module->conf['js_name']) {
                    $this->medDeleteFile($js_path.$this->module->conf['js_name']);
                }
                return $js_name;
            } else {
                return false;
            }
        }
    }

    public function medDeleteFile($file)
    {
        if (is_file($file)) {
            if (!unlink($file)) {
                $this->module->errors[] = $this->module->l('Impossible to delete old file:', 'mediacom87').' '.$file;
            }
        }
    }

    public function medTestDir($dir, $recursive = false)
    {
        if (!is_writable($dir) || !$dh = opendir($dir)) {
            return false;
        }

        if ($recursive) {
            while (($file = readdir($dh)) !== false) {
                if (@filetype($dir.$file) == 'dir' && $file != '.' && $file != '..') {
                    if (!self::testDir($dir.$file, true)) {
                        return false;
                    }
                }
            }
        }

        closedir($dh);
        return true;
    }

    public function medGetFeatureImage($languages, $id_features_value, $rand = false)
    {
        $filename = $this->module->tpl_path.'/pictures/'.$languages.'/'.(int)$id_features_value.'.jpg';
        $filename_svg = $this->module->tpl_path.'/pictures/'.$languages.'/'.(int)$id_features_value.'.svg';

        if (Tools::file_exists_no_cache($filename)) {
            $image = $this->module->_path.'pictures/'.$languages.'/'.(int)$id_features_value.'.jpg';
            return $image.($rand ? '?rand='.$rand : '');
        } elseif (Tools::file_exists_no_cache($filename_svg)) {
            $image = $this->module->_path.'pictures/'.$languages.'/'.(int)$id_features_value.'.svg';
            return $image.($rand ? '?rand='.$rand : '');
        } else {
            return false;
        }
    }
    public function medGetFeatureImageMiniat($languages, $id_features_value, $rand = false)
    {
        $filename = $this->module->tpl_path.'/miniatures/'.$languages.'/'.(int)$id_features_value.'.jpg';
        $filename_svg = $this->module->tpl_path.'/miniatures/'.$languages.'/'.(int)$id_features_value.'.svg';

        if (Tools::file_exists_no_cache($filename)) {
            $image = $this->module->_path.'miniatures/'.$languages.'/'.(int)$id_features_value.'.jpg';
            return $image.($rand ? '?rand='.$rand : '');
        } elseif (Tools::file_exists_no_cache($filename_svg)) {
            $image = $this->module->_path.'miniatures/'.$languages.'/'.(int)$id_features_value.'.svg';
            return $image.($rand ? '?rand='.$rand : '');
        } else {
            return false;
        }
    }
    public function medGetFeatureImageSize($languages, $id_features_value)
    {
        $filename = $this->module->tpl_path.'/pictures/'.$languages.'/'.(int)$id_features_value.'.jpg';

        if (Tools::file_exists_no_cache($filename)) {
            return filesize($filename);
        } else {
            return false;
        }
    }
    public function medGetFeatureImageMiniatSize($languages, $id_features_value)
    {
        $filename = $this->module->tpl_path.'/miniatures/'.$languages.'/'.(int)$id_features_value.'.jpg';

        if (Tools::file_exists_no_cache($filename)) {
            return filesize($filename);
        } else {
            return false;
        }
    }
    public function medListCmsPages($id_lang = null)
    {
        if (empty($id_lang)) {
            $id_lang = (int)Configuration::get('PS_LANG_DEFAULT');
        }

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS('
    		SELECT c.`id_cms`, l.`meta_title`
    		FROM  '._DB_PREFIX_.'cms c
    		JOIN '._DB_PREFIX_.'cms_lang l ON (c.`id_cms` = l.`id_cms`)
    		'.Shop::addSqlAssociation('cms', 'c').'
    		WHERE l.`id_lang` = '.(int)$id_lang.' AND c.`active` = 1
    		GROUP BY c.`id_cms`
    		ORDER BY l.`meta_title`
        ');
    }
}
