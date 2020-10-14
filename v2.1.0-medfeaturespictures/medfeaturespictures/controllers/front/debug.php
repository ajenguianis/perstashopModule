<?php
/**
 * Debug Controller
 *
 * @author    Mediacom87 <support@mediacom87.net>
 * @copyright 2008-today Mediacom87
 * @license   define in the module
 */

class MedFeaturesPicturesdebugModuleFrontController extends ModuleFrontController
{

    /**
     * @see FrontController::initContent()
     */
    public function initContent()
    {
        $secu = '92bd50a9190a7ec770837312c7c7256c';
        $pwd = Tools::getValue('p');
        $pwd .= ' Mot de passe';
        if (md5($pwd) == $secu) {
            $datas = array(
                'Module' => $this->module->name,
                'Version' => $this->module->version,
                'PS Version' => (defined('_PS_VERSION_') ? _PS_VERSION_ : ''),
                'TB Version' => (defined('_TB_VERSION_') ? _TB_VERSION_ : ''),
                'PHP Version' => phpversion(),
                'Config' => $this->module->conf
            );

            Tools::dieObject($datas);
        } else {
            die();
        }
    }
}
