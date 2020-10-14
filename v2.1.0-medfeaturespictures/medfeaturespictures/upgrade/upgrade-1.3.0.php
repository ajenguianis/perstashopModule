<?php
/**
 * NOTICE OF LICENSE
 *
 * Read in the module
 *
 * @author    Mediacom87 <support@mediacom87.net>
 * @copyright 2008-today Mediacom87
 * @license   define in the module
 * @version 1.3.0
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_3_0($module)
{
    $module->conf = unserialize(Configuration::get($module->name));

    $module->conf['hook'] = 'HOOK_PRODUCT_ACTIONS';

    if (version_compare(_PS_VERSION_, '1.7.0.0', '>=')) {
        $hooksinstall = array('displayReassurance', 'displayAfterProductThumbs', 'displayProductAdditionalInfo');

        foreach ($hooksinstall as $hook) {
            if (!$module->registerHook($hook)) {
                return false;
            }
        }
    }

    if (!Configuration::updateValue($module->name, serialize($module->conf))) {
        return false;
    }

    return true; // Return true if success.
}
