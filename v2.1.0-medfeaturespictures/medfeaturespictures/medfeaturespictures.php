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
 * @version 2.1.0
 */

if (!defined('_TB_VERSION_')
    && !defined('_PS_VERSION_')) {
    exit;
}

include_once dirname(__FILE__).'/class/mediacom87.php';

class MedFeaturesPictures extends Module
{
    public $smarty;
    public $context;
    public $controller;
    public $_path;
    private $errors = array();
    protected $config_form = false;

    public function __construct()
    {
        $this->name = 'medfeaturespictures';
        $this->tab = 'front_office_features';
        $this->version = '2.1.0';
        $this->author = 'Mediacom87';
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => '1.7.99.99');
        $this->need_instance = 0;
        $this->module_key = 'ed3f5dcb57975522ae3ca57ec98a7168'; // ed3f5dcb57975522ae3ca57ec98a7168
        $this->addons_id = '22378'; // 22378
        $this->author_address = '0x58fc3c5faebac44d590fa20ca7757cc802ad2708'; // 0x58fc3c5faebac44d590fa20ca7757cc802ad2708

        parent::__construct();

        $this->displayName = $this->l('Attach images to your features');
        $this->description = $this->l('This module allows you to associate images (icons) to your features.');

        $this->bootstrap = true;

        $this->mediacom87 = new MedFeaturesPicturesClass($this);

        $this->conf = unserialize(Configuration::get($this->name));
        $this->tpl_path = _PS_ROOT_DIR_.'/modules/'.$this->name;
    }

    public function install()
    {
        if (!parent::install()
            || !$this->registerHook('addproduct')
            || !$this->registerHook('updateproduct')
            || !$this->registerHook('deleteproduct')
            || !$this->registerHook('MedFeaturesPictures')
            || !$this->defaultConf()) {
            return false;
        }

        if (version_compare(_PS_VERSION_, '1.7.0.0', '>=')) {
            $hooksinstall = array(
                'displayReassurance',
                'displayAfterProductThumbs',
                'displayProductAdditionalInfo',
                'actionFrontControllerSetMedia'
            );
        } else {
            $hooksinstall = array(
                'displayheader',
                'productactions',
                'extraright',
                'extraleft',
                'productfooter'
            );
        }

        foreach ($hooksinstall as $hook) {
            if (!$this->registerHook($hook)) {
                return false;
            }
        }

        $this->_clearCache('*');

        return true;
    }

    public function defaultConf()
    {
        $conf = array();

        $conf['DISPLAY_TITLE'] = 1;
        $conf['UNDER_PIX'] = 0;
        $conf['TOOLTIP'] = 0;
        $conf['NB_PRODUCTS_XS'] = 3;
        $conf['NB_PRODUCTS_SM'] = 3;
        $conf['NB_PRODUCTS_MD'] = 3;
        $conf['NB_PRODUCTS_LG'] = 3;
        $conf['URL_DISPLAY'] = 'modal';
        $conf['ID_CMS'] = array();
        $conf['hook'] = 'HOOK_PRODUCT_FOOTER';
        $conf['image_width'] = 0;
        $conf['image_eight'] = 0;
        $conf['css_name'] = '';
        $conf['js_name'] = '';

        if (!Configuration::updateValue($this->name, serialize($conf))) {
            return false;
        }

        return true;
    }

    public function uninstall()
    {

        if (!parent::uninstall() || !Configuration::deleteByName($this->name)) {
            return false;
        }

        foreach (glob($this->tpl_path.'/views/js/script-*.js') as $file) {
            unlink($file);
        }

        foreach (glob($this->tpl_path.'/views/css/style-*.css') as $file) {
            unlink($file);
        }

        foreach (Language::getLanguages(false) as $lang) {
            $arr1 = glob($this->tpl_path.'/pictures/'.$lang['iso_code'].'/*.svg');
            $arr2 = glob($this->tpl_path.'/pictures/'.$lang['iso_code'].'/*.jpg');
            $files = array_merge($arr1, $arr2);
            foreach ($files as $file) {
                unlink($file);
            }
        }

        $this->_clearCache('*');

        return true;
    }

    public function getContent($tab = 'AdminModules')
    {
        $this->errors = array();
        $output = '';
        $script = '';
        $languages = Language::getLanguages(false);

        if (count($languages) > 1) {
            $multi_languages = 1;
        } else {
            $multi_languages = 0;
        }

        /* test and create iso folder for pictures */
        $this->checkIsoFolders($languages, $this->tpl_path);

        /* Save Pictures */
        if (Tools::isSubmit('savepicture')) {
            $this->postProcessPicture($languages);

            if (!count($this->errors)) {
                $output .= $this->displayConfirmation($this->l('Images updated'));
            }
        } elseif (Tools::isSubmit('saveconf')) {
            $this->postProcess();

            if (!count($this->errors)) {
                $output .= $this->displayConfirmation($this->l('Settings updated'));
            }
        } elseif (Tools::getValue('back_action') == 'delete_all_pictures' && $id_feature_value = Tools::getValue('id_feature_value')) {
            foreach ($languages as $lang) {
                $filename = $this->tpl_path.'/pictures/'.$lang['iso_code'].'/'.$id_feature_value.'.*';
                foreach (glob($filename) as $file) {
                    unlink($file);
                }
            }

            $output .= $this->displayConfirmation($this->l('Images deleted successfully'));
        } elseif (Tools::getValue('del_picture') && Tools::getValue('iso_code')) {
            $filename = $this->tpl_path.'/pictures/'.Tools::getValue('iso_code').'/'.Tools::getValue('del_picture').'.*';
            foreach (glob($filename) as $file) {
                unlink($file);
            }
            $output .= $this->displayConfirmation($this->l('Image deleted successfully'));
        }

        if (isset($this->addons_id) && $this->addons_id) {
            $json_rates = $this->mediacom87->medJsonModuleRate($this->addons_id, $this->module_key);
        } else {
            $json_rates = false;
        }

        if (isset($this->module_key) && $this->module_key) {
            $json_modules = $this->mediacom87->medJsonModuleFile();
        } else {
            $json_modules = null;
        }

        $form_url = AdminController::$currentIndex
            .'&amp;configure='.$this->name
            .'&amp;token='.Tools::getAdminToken(
                $tab
                .(int)Tab::getIdFromClassName($tab)
                .(int)$this->context->cookie->id_employee
            );

        $this->context->smarty->assign(
            array(
                'form_url' => $form_url,
                'addons_id' => $this->addons_id,
                'tpl_path' => $this->tpl_path,
                'img_path' => $this->_path.'views/img/',
                'languages' => $languages,
                'description' => $this->description,
                'author' => $this->author,
                'name' => $this->name,
                'version' => $this->version,
                'ps_version' => defined('_PS_VERSION_') ? _PS_VERSION_ : null,
                'tb_version' => defined('_TB_VERSION_') ? _TB_VERSION_ : null,
                'php_version' => phpversion(),
                'iso_code' => $this->mediacom87->isoCode(),
                'iso_domain' => $this->mediacom87->isoCode(true),
                'id_active_lang' => (int)$this->context->language->id,
                'json_modules' => $json_modules,
                'json_rates' => $json_rates,
                'hookname' => '{hook h="MedFeaturesPictures"}',
                'config' => $this->conf
            )
        );

        if (count($this->errors)) {
            $output .= $this->displayError(implode('<br />', $this->errors));
        }

        if (Tools::getValue('action') == 'display_feature'
            && $id_feature = Tools::getValue('id_feature')) {
            /* Display Features value fo a feature */
            $list = array();
            $feature_active = Feature::getFeature((int)$this->context->language->id, $id_feature);

            foreach (FeatureValue::getFeatureValuesWithLang((int)$this->context->language->id, $id_feature, true) as $feature) {
                foreach ($languages as $lang) {
                    if (!$feature[$lang['iso_code']] = $this->mediacom87->medGetFeatureImage($lang['iso_code'], $feature['id_feature_value'], mt_rand())) {
                        $feature[$lang['iso_code']] = $this->l('No picture');
                    }
                }

                $list[] = $feature;
            }

            $columns = array();
            $columns[] = array(
                'content' => 'ID',
                'key' => 'id_feature_value',
                'center' => true
            );
            $columns[] = array(
                'content' => $this->l('Value'),
                'key' => 'value'
            );

            foreach ($languages as $lang) {
                $columns[] = array(
                    'content' => '../img/l/'.$lang['id_lang'].'.jpg',
                    'key' => $lang['iso_code'],
                    'center' => true
                );
            }

            $this->context->smarty->assign(
                array(
                    'data' => Tools::jsonEncode(
                        array(
                            'columns' => $columns,
                            'rows' => $list,
                            'rows_actions' => array(
                                array(
                                    'title' => ($multi_languages ? $this->l('Edit pictures') : $this->l('Edit picture')),
                                    'action' => 'edit_picture&back_action=display_feature',
                                    'icon' => 'edit'
                                ),
                                array(
                                    'title' => ($multi_languages ? $this->l('Delete all pictures') : $this->l('Delete picture')),
                                    'action' => 'display_feature&back_action=delete_all_pictures',
                                    'icon' => 'trash'
                                ),
                            ),
                            'url_params' => array(
                                'configure' => $this->name,
                                'id_feature' => $id_feature
                            ),
                            'identifier' => 'id_feature_value'
                        )
                    ),
                    'feature_name' => $feature_active['name'],
                    'url_manager' => Context::getContext()->link->getAdminLink('AdminFeatures')
                    .'&id_feature='.$id_feature
                    .'&addfeature_value'
                )
            );

            $this->context->smarty->assign('tplFile', '_feature.tpl');
        } elseif (Tools::getValue('action') == 'edit_picture' && $id_feature_value = Tools::getValue('id_feature_value')) {
            /* Picture Editing */
            $id_feature = Tools::getValue('id_feature');
            $feature_active = Feature::getFeature((int)$this->context->language->id, $id_feature);

            $images = array();
            $image_uploader = array();

            foreach ($languages as $lang) {
                if (!$images[$lang['iso_code']] = $this->mediacom87->medGetFeatureImage($lang['iso_code'], $id_feature_value, mt_rand())) {
                    $images[$lang['iso_code']] = null;
                    $delete_url = null;
                    $image_size = null;
                } else {
                    $delete_url = $form_url
                        .'&del_picture='.$id_feature_value
                        .'&iso_code='.$lang['iso_code']
                        .'&action=edit_picture&back_action='.Tools::getValue('back_action')
                        .'&id_feature='.$id_feature
                        .'&id_feature_value='.$id_feature_value;
                    $image_size = $this->mediacom87->medGetFeatureImageSize($lang['iso_code'], $id_feature_value) / 1000;
                }
                $code = $this->medGenUploadByLang($lang['iso_code'], $images[$lang['iso_code']], $delete_url, $image_size);
                $image_uploader[$lang['iso_code']] = $code['html'];
                $script .= $code['script'];
            }

            foreach (FeatureValue::getFeatureValueLang($id_feature_value) as $v) {
                if ((int)$v['id_lang'] == (int)$this->context->language->id) {
                    $feature_value_name = $v['value'];
                    break;
                }
            }

            $this->context->smarty->assign(
                array(
                    'images' => $images,
                    'image_uploader' => $image_uploader,
                    'cms_pages' => $this->mediacom87->medListCmsPages((int)$this->context->language->id),
                    'feature_value_name' => $feature_value_name,
                    'id_feature_value' => $id_feature_value,
                    'id_feature' => $id_feature,
                    'f_name' => $feature_active['name'],
                    'back_action' => Tools::getValue('back_action'),
                    'tplFile' => '_picture.tpl'
                )
            );
        } else {
            /* Default Display */
            $list = array();

            foreach (Feature::getFeatures((int)$this->context->language->id) as $feature) {
                $feature['count'] = count(FeatureValue::getFeatureValuesWithLang((int)$this->context->language->id, $feature['id_feature'], true));

                if ($feature['count'] > 0) {
                    $list[] = $feature;
                }
            }

            $this->context->smarty->assign(
                array(
                    'data' => Tools::jsonEncode(
                        array(
                        'columns' => array(
                            array(
                                'content' => 'ID',
                                'key' => 'id_feature',
                                'center' => true
                            ),
                            array(
                                'content' => $this->l('Name'),
                                'key' => 'name'
                            ),
                            array(
                                'content' => $this->l('Number of values'),
                                'key' => 'count'
                            ),
                        ),
                        'rows' => $list,
                        'rows_actions' => array(
                            array(
                                'title' => $this->l('Display Values'),
                                'action' => 'display_feature',
                                'icon' => 'search-plus'
                            ),
                        ),
                        'url_params' => array('configure' => $this->name),
                        'identifier' => 'id_feature',
                        )
                    ),
                    'url_manager' => Context::getContext()->link->getAdminLink('AdminFeatures')
                )
            );

            $this->context->smarty->assign('tplFile', '_initial.tpl');
        }

        $this->context->controller->addJS(
            array(
                $this->_path.'libraries/js/riotcompiler.min.js',
                $this->_path.'libraries/js/pageloader.js'
            )
        );

        $this->context->controller->addCSS($this->_path.'views/css/back.css');

        $output .= $this->display(__FILE__, 'views/templates/admin/admin.tpl');
        $output .= $script;
        $output .= $this->display(__FILE__, 'libraries/prestui/ps-tags.tpl');

        return $output;
    }

    public function medGenUploadByLang($iso_code, $url = null, $delete_url = null, $image_size = null)
    {
        $image_uploader = new HelperImageUploader('picture_'.$iso_code);
        if ($url) {
            $file = array(
                array(
                    'type' => 'image',
                    'image' => '<img class="img-responsive" src="'.$url.'" />',
                    'size' => $image_size,
                    'delete_url' => $delete_url
                )
            );
            $image_uploader->setFiles($file);
        }
        $code = $image_uploader->render();
        list($html, $script) = explode('<script ', $code);
        return array(
            'html' => $html,
            'script' => '<script '.$script
        );
    }

    private function postProcess()
    {
        $this->conf['DISPLAY_TITLE']    = (int)Tools::getValue('DISPLAY_TITLE');
        $this->conf['UNDER_PIX']        = (int)Tools::getValue('UNDER_PIX');
        $this->conf['TOOLTIP']          = (int)Tools::getValue('TOOLTIP');
        $this->conf['NB_PRODUCTS_XS']      = (int)Tools::getValue('NB_PRODUCTS_XS');
        $this->conf['NB_PRODUCTS_SM']      = (int)Tools::getValue('NB_PRODUCTS_SM');
        $this->conf['NB_PRODUCTS_MD']      = (int)Tools::getValue('NB_PRODUCTS_MD');
        $this->conf['NB_PRODUCTS_LG']      = (int)Tools::getValue('NB_PRODUCTS_LG');
        $this->conf['URL_DISPLAY']      = Tools::getValue('URL_DISPLAY');
        $this->conf['hook']             = Tools::getValue('hook');
        $this->conf['image_width']      = (int)Tools::getValue('image_width');
        $this->conf['image_eight']      = (int)Tools::getValue('image_eight');

        foreach (Language::getLanguages(false) as $lang) {
            $this->conf['blocktitletext'][(int)$lang['id_lang']] = (string)Tools::getValue('blocktitletext_'.(int)$lang['id_lang']);
        }

        if ($this->conf['image_width']
            || $this->conf['image_eight']) {
            if (!$this->conf['css_name'] = $this->mediacom87->medGenerateCSS(__FILE__)) {
                $this->errors[] = $this->l('Error during css file generation');
            }
        } else {
            if ($this->conf['css_name']) {
                $this->mediacom87->medDeleteFile($this->tpl_path.'/views/css/'.$this->conf['css_name']);
            }
            $this->conf['css_name'] = false;
        }

        if (isset($this->conf['TOOLTIP'])
            && $this->conf['TOOLTIP']) {
            if (!$this->conf['js_name'] = $this->mediacom87->medGenerateJS(__FILE__)) {
                $this->errors[] = $this->l('Error during js file generation');
            }
        } else {
            if (isset($this->conf['js_name'])
                && $this->conf['js_name']) {
                $this->mediacom87->medDeleteFile($this->tpl_path.'/views/js/'.$this->conf['js_name']);
            }
            $this->conf['js_name'] = false;
        }

        if ($this->conf['hook'] !== false) {
            if (Configuration::updateValue($this->name, serialize($this->conf))) {
                $this->_clearCache('*');
                return true;
            } else {
                $this->errors[] = $this->l('Error during saving settings');
            }
        }

        return false;
    }

    public function postProcessPicture($languages)
    {
        $id_feature_value = (int)Tools::getValue('id_feature_value');

        $same_image = (int)Tools::getValue('same_image');
        $same_iso_code = false;
        $svg_file = false;

        foreach ($languages as $lang) {
            $iso_code = $lang['iso_code'];
            if ($same_image && $same_iso_code) {
                $iso_code = $same_iso_code;
            }
            if (isset($_FILES['picture_'.$iso_code]['tmp_name']) && $_FILES['picture_'.$iso_code]['tmp_name']) {
                $source = $_FILES['picture_'.$iso_code]['tmp_name'];
                if ($svg_file || mime_content_type($source) == 'image/svg+xml') {
                    $svg_file = true;
                    $dest = _PS_MODULE_DIR_.$this->name.'/pictures/'.$lang['iso_code'].'/'.$id_feature_value.'.svg';
                    if ($same_image && $same_iso_code) {
                        $source = $this->tpl_path.'/pictures/'.$iso_code.'/'.$id_feature_value.'.svg';
                        if (!copy($source, $dest)) {
                            $this->errors[] = sprintf($this->l('Error when saving the SVG image for %s'), $lang['name']);
                        }
                    } elseif (!move_uploaded_file($source, $dest)) {
                        $this->errors[] = sprintf($this->l('Error when saving the SVG image for %s'), $lang['name']);
                    } elseif ($same_image && !$same_iso_code) {
                        $same_iso_code = $lang['iso_code'];
                    }
                } else {
                    $dest = _PS_MODULE_DIR_.$this->name.'/pictures/'.$lang['iso_code'].'/'.$id_feature_value.'.jpg';
                    if (!ImageManager::resize($source, $dest, $this->conf['image_width'], $this->conf['image_eight'])) {
                        if ($same_image) {
                            $source = _PS_MODULE_DIR_.$this->name.'/pictures/'.$iso_code.'/'.$id_feature_value.'.jpg';
                            if (!ImageManager::resize($source, $dest, $this->conf['image_width'], $this->conf['image_eight'])) {
                                $this->errors[] = sprintf($this->l('Error while saving the image for %s'), $lang['name']);
                            }
                        } else {
                            $this->errors[] = sprintf($this->l('Error while saving the image for %s'), $lang['name']);
                        }
                    } elseif ($same_image && !$same_iso_code) {
                        $same_iso_code = $lang['iso_code'];
                    }
                }
            }
        }

        if (($id_cms = (int)Tools::getValue('id_cms')) && $id_cms != 9999999999) {
            $this->conf['ID_CMS'][(int)$id_feature_value] = $id_cms;

            if (!Configuration::updateValue($this->name, serialize($this->conf))) {
                $this->errors[] = $this->l('Error during the recording of the defined CMS page link');
            }
        }

        $this->_clearCache('*');
    }

    private function checkIsoFolders($languages)
    {
        foreach ($languages as $lang) {
            $dir = $this->tpl_path.'/pictures/'.$lang['iso_code'];

            if (!$this->mediacom87->medTestDir($dir)) {
                if (!mkdir($dir, 0755)) {
                    $this->errors[] = sprintf($this->l('Error during %s directory creation, you need to do it manually to use this module'), '/modules/'.$this->name.'/pictures/'.$lang['iso_code']);
                } else {
                    copy($this->tpl_path.'/pictures/index.php', $dir.'/index.php');
                }
            }
        }

        return true;
    }

    public function hookAddProduct($params)
    {
        $this->_clearCache('*');
    }

    public function hookUpdateProduct($params)
    {
        $this->_clearCache('*');
    }

    public function hookDeleteProduct($params)
    {
        $this->_clearCache('*');
    }

    public function hookDisplayReassurance()
    {
        if ($this->conf['hook'] == 'displayReassurance') {
            return $this->displayFeaturesPictures((int)Tools::getValue('id_product'));
        }
    }

    public function hookDisplayAfterProductThumbs()
    {
        if ($this->conf['hook'] == 'displayAfterProductThumbs') {
            return $this->displayFeaturesPictures((int)Tools::getValue('id_product'));
        }
    }

    public function hookDisplayProductAdditionalInfo()
    {
        if ($this->conf['hook'] == 'displayProductAdditionalInfo') {
            return $this->displayFeaturesPictures((int)Tools::getValue('id_product'));
        }
    }

    public function hookProductActions()
    {
        if ($this->conf['hook'] == 'HOOK_PRODUCT_ACTIONS') {
            return $this->displayFeaturesPictures((int)Tools::getValue('id_product'));
        }
    }

    public function hookExtraRight()
    {
        if ($this->conf['hook'] == 'HOOK_EXTRA_RIGHT') {
            return $this->displayFeaturesPictures((int)Tools::getValue('id_product'));
        }
    }

    public function hookExtraLeft()
    {
        if ($this->conf['hook'] == 'HOOK_EXTRA_LEFT') {
            return $this->displayFeaturesPictures((int)Tools::getValue('id_product'));
        }
    }

    public function hookProductFooter()
    {
        if ($this->conf['hook'] == 'HOOK_PRODUCT_FOOTER') {
            return $this->displayFeaturesPictures((int)Tools::getValue('id_product'));
        }
    }

    public function hookMedFeaturesPictures()
    {
        if ($this->conf['hook'] == 'hookMedFeaturesPictures') {
            return $this->displayFeaturesPictures((int)Tools::getValue('id_product'));
        }
    }

    public function hookActionFrontControllerSetMedia($params)
    {
        if ('product' === $this->context->controller->php_self) {
            $this->context->controller->registerStylesheet(
                'module-medfeaturespictures-style-fbox',
                'modules/'.$this->name.'/libraries/js/fbox/jquery.fbox.min.css',
                array(
                    'media' => 'all',
                    'priority' => 200,
                )
            );
            if (isset($this->conf['css_name'])
                && $this->conf['css_name']) {
                $this->context->controller->registerStylesheet(
                    'module-medfeaturespictures-style'.$this->conf['css_name'],
                    'modules/'.$this->name.'/views/css/'.$this->conf['css_name'],
                    array(
                        'media' => 'all',
                        'priority' => 200,
                    )
                );
            }
            $this->context->controller->registerStylesheet(
                'module-medfeaturespictures-'.$this->name,
                'modules/'.$this->name.'/views/css/'.$this->name.'.css',
                array(
                    'media' => 'all',
                    'priority' => 200,
                )
            );
            $this->context->controller->registerJavascript(
                'module-medfeaturespictures-js-fbox',
                'modules/'.$this->name.'/libraries/js/fbox/jquery.fbox.min.js',
                array(
                    'priority' => 200,
                )
            );
            if (isset($this->conf['TOOLTIP'])
                && $this->conf['TOOLTIP']) {
                $this->context->controller->registerStylesheet(
                    'module-medfeaturespictures-style-tooltipster',
                    'modules/'.$this->name.'/libraries/tooltipster/dist/css/tooltipster.bundle.min.css',
                    array(
                        'media' => 'all',
                        'priority' => 200,
                    )
                );
                $this->context->controller->registerJavascript(
                    'module-medfeaturespictures-js-tooltipster',
                    'modules/'.$this->name.'/libraries/tooltipster/dist/js/tooltipster.bundle.min.js',
                    array(
                        'priority' => 200,
                    )
                );
                if (isset($this->conf['js_name'])
                    && $this->conf['js_name']) {
                    $this->context->controller->registerJavascript(
                        'module-medfeaturespictures-js'.$this->conf['js_name'],
                        'modules/'.$this->name.'/views/js/'.$this->conf['js_name'],
                        array(
                            'priority' => 200,
                        )
                    );
                }
            }
        }
    }

    public function hookDisplayHeader()
    {
        if ('product' === $this->context->controller->php_self) {
            $this->context->controller->addCSS($this->_path.'views/css/'.$this->name.'.css', 'all');
            if (isset($this->conf['css_name'])
                && $this->conf['css_name']) {
                $this->context->controller->addCSS($this->_path.'views/css/'.$this->conf['css_name'], 'all');
            }
            if (isset($this->conf['TOOLTIP'])
                && $this->conf['TOOLTIP']) {
                $this->context->controller->addCSS($this->_path.'libraries/tooltipster/dist/css/tooltipster.bundle.min.css', 'all');
                $this->context->controller->addJS($this->_path.'libraries/tooltipster/dist/js/tooltipster.bundle.min.js');
                if (isset($this->conf['js_name'])
                    && $this->conf['js_name']) {
                    $this->context->controller->addJS($this->_path.'views/js/'.$this->conf['js_name']);
                }
            }
        }
    }

    public function displayFeaturesPictures($id_product)
    {
        $cache_id = $this->name
            .'|'.(int)$id_product
            .'|'.(int)$this->context->language->id
            .'|'.$this->context->currency->id;

        if (!$this->isCached($this->name.'.tpl', $this->getCacheId($cache_id))) {
            $features = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS(
                'SELECT name, value, fvl.id_feature_value
				FROM '._DB_PREFIX_.'feature_product pf
				LEFT JOIN '._DB_PREFIX_.'feature_lang fl
				    ON (fl.id_feature = pf.id_feature AND fl.id_lang = '.(int)$this->context->language->id.')
				LEFT JOIN '._DB_PREFIX_.'feature_value_lang fvl
				    ON (fvl.id_feature_value = pf.id_feature_value AND fvl.id_lang = '.(int)$this->context->language->id.')
				LEFT JOIN '._DB_PREFIX_.'feature f
				    ON (f.id_feature = pf.id_feature AND fl.id_lang = '.(int)$this->context->language->id.')
				'.Shop::addSqlAssociation('feature', 'f').'
				WHERE pf.id_product = '.(int)$id_product.'
				ORDER BY f.position ASC'
            );

            $images = array();

            foreach ($features as $feature) {
                if ($image = $this->mediacom87->medGetFeatureImage($this->context->language->iso_code, $feature['id_feature_value'])) {
                    $feature['url'] = $image;
                    $images[] = $feature;
                }
            }

            if (!count($images)) {
                return;
            }

            $this->context->smarty->assign(array(
                    'features' => $images,
                    'config' => $this->conf,
                    'ps_version' => _PS_VERSION_,
                    'id_lang' => (int)$this->context->language->id
                ));
        }

        return $this->display(__FILE__, $this->name.'.tpl', $this->getCacheId($cache_id));
    }
}
