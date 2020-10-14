{*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade this module to newer
* versions in the future. If you wish to customize this module for your
* needs please refer to http://doc.prestashop.com/display/PS15/Overriding+default+behaviors
* #Overridingdefaultbehaviors-Overridingamodule%27sbehavior for more information.
*
* @author Mediacom87 <support@mediacom87.net>
* @copyright  Mediacom87
* @license    commercial license see tab in the module
*}

.medfeaturespictures img {ldelim}
    {if isset($config.image_width) && $config.image_width}max-width : {$config.image_width|escape:'html':'UTF-8'}px;{/if}
    {if isset($config.image_eight) && $config.image_eight}max-height : {$config.image_eight|escape:'html':'UTF-8'}px;{/if}
{rdelim}
