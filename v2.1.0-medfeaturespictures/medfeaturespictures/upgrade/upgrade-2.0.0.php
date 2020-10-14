<?php
/**
 * NOTICE OF LICENSE
 *
 * Read in the module
 *
 * @author    Mediacom87 <support@mediacom87.net>
 * @copyright 2008-today Mediacom87
 * @license   define in the module
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_2_0_0($module)
{
    if (isset($module->conf['DISPLAY_VALUE'])) {
        $module->conf['UNDER_PIX'] = $module->conf['DISPLAY_VALUE'];
    } else {
        $module->conf['UNDER_PIX'] = 0;
    }
    $module->conf['NB_PRODUCTS_XS'] = $module->conf['NB_PRODUCTS'];
    $module->conf['NB_PRODUCTS_SM'] = $module->conf['NB_PRODUCTS'];
    $module->conf['NB_PRODUCTS_MD'] = $module->conf['NB_PRODUCTS'];
    $module->conf['NB_PRODUCTS_LG'] = $module->conf['NB_PRODUCTS'];
    $module->conf['TOOLTIP'] = 0;
    $module->conf['css_name'] = 0;
    $module->conf['js_name'] = 0;
    if (!Configuration::updateValue($module->name, serialize($module->conf))) {
        return false;
    }
    return true;
}
