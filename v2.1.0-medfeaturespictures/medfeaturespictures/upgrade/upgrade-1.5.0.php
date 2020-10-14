<?php
/**
 * NOTICE OF LICENSE
 *
 * Read in the module
 *
 * @author    Mediacom87 <support@mediacom87.net>
 * @copyright 2008-today Mediacom87
 * @license   define in the module
 * @version 1.5.0
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_5_0($module)
{
    $module->conf['image_width'] = 0;
    $module->conf['image_eight'] = 0;
    if (!Configuration::updateValue($module->name, serialize($module->conf))) {
        return false;
    }
    if (!$module->registerHook('MedFeaturesPictures')) {
        return false;
    }
    return true;
}
