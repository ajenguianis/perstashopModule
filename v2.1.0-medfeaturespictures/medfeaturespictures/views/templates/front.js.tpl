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

$(document).ready(function(){ldelim}
	{if isset($config.TOOLTIP) && $config.TOOLTIP}
        $('.medttips').tooltipster({ldelim}
            repositionOnScroll: true,
        {rdelim});
	{/if}
{rdelim});
