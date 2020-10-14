<?php
/**
 * NOTICE OF LICENSE
 *
 * Read in the module
 *
 * @author    Mediacom87 <support@mediacom87.net>
 * @copyright 2008-2016 Mediacom87
 * @license   define in the module
 * @version 1.2.0
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

/**
 * upgrade_module_1_2_0 function.
 *
 * @access public
 * @param mixed $module
 * @return void
 */
function upgrade_module_1_2_0($module)
{
    $module->conf = unserialize(Configuration::get($module->name));

    $module->conf['URL_DISPLAY'] = 'modal';
    $module->conf['ID_CMS'] = array();

    if (!Configuration::updateValue($module->name, serialize($module->conf))) {
        return false;
    }

    return true; // Return true if success.
}
