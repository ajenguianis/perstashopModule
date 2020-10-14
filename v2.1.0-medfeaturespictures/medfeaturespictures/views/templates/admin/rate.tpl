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

<ps-alert-hint class="medAddonsMarket">

    {if isset($json_rates) && $json_rates.avgRate >= 70}
    <p>{l s='%d users love our module' sprintf=$json_rates.nbRates mod='medfeaturespictures'}</p>
    <p><span class="medRateModule"><span style="width:{$json_rates.avgRate|escape:'htmlall':'UTF-8'}%;{if $json_rates.avgRate > 99} border-radius:5px{/if}">{$json_rates.avgRate|escape:'htmlall':'UTF-8'}%</span></span></p>
    {/if}
    <p>{l s='Feel free to share your opinion' mod='medfeaturespictures'}</p>
    <p class="medRateModule"><a href="https://addons.prestashop.com/ratings.php" target="_blank" title="Rate this module directly on PrestaShop Addons"><i class="process-icon-thumbs-up fa fa-thumbs-up fa-4x" aria-hidden="true"></i>
</a></p>

</ps-alert-hint>
