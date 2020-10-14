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

<!--Start of MedFeaturePrice by Mediacom87-->

<div class="row medfeaturespictures">

    {if isset($config.DISPLAY_TITLE) && $config.DISPLAY_TITLE}
        <h4 class="col-xs-12">{if isset($config.blocktitletext.{$id_lang}) && $config.blocktitletext.{$id_lang}}{$config.blocktitletext.{$id_lang}|escape:'html':'UTF-8'}{else}{l s='Data sheet' mod='medfeaturespictures'}{/if}</h4>
    {/if}

    {foreach from=$features item=item}

        <div class="col-xs-{$config.NB_PRODUCTS_XS|escape:'html':'UTF-8'} col-sm-{$config.NB_PRODUCTS_SM|escape:'html':'UTF-8'} col-md-{$config.NB_PRODUCTS_MD|escape:'html':'UTF-8'} col-lg-{$config.NB_PRODUCTS_LG|escape:'html':'UTF-8'}">
            <p>

                {if isset($config.ID_CMS[$item.id_feature_value]) && $config.ID_CMS[$item.id_feature_value]}
                    {if $ps_version >= 1.7}
                        <a {if $config.URL_DISPLAY != 'modal'} target="_blank" href="{$link->getCMSLink($config.ID_CMS[$item.id_feature_value])|escape:'html':'UTF-8'}"{else} data-fancybox data-type="iframe" data-src="{$link->getCMSLink($config.ID_CMS[$item.id_feature_value])|escape:'html':'UTF-8'}?content_only=1" href="javascript:;"{/if} rel="nofollow">
                    {else}
                        <a href="{$link->getCMSLink($config.ID_CMS[$item.id_feature_value])|escape:'html':'UTF-8'}{if $config.URL_DISPLAY == 'modal'}?content_only=1" class="iframe"{else}" target="_blank"{/if} rel="nofollow">
                    {/if}
                {/if}

                <img class="img-responsive{if isset($config.TOOLTIP) && $config.TOOLTIP} medttips{/if}" src="{$item.url|escape:'html':'UTF-8'}" alt="{$item.name|escape:'html':'UTF-8'} : {$item.value|escape:'html':'UTF-8'}" title="{$item.name|escape:'html':'UTF-8'} : {$item.value|escape:'html':'UTF-8'}" />

                {if isset($config.UNDER_PIX) && $config.UNDER_PIX}<span class="clearfix{if $ps_version >= 1.7} col-xs-12{/if}">{$item.value|escape:'html':'UTF-8'}</span>{/if}

                {if isset($config.ID_CMS[$item.id_feature_value]) && $config.ID_CMS[$item.id_feature_value]}</a>{/if}

            </p>

        </div>

    {/foreach}

    <div class="clearfix">&nbsp;</div>

</div>

{if $ps_version < 1.7 && $config.URL_DISPLAY == 'modal'}
<script type="text/javascript">
$(document).ready(function() {
$('div.medfeaturespictures a.iframe').fancybox({
		'type' : 'iframe'
	});
});
</script>
{/if}

<!--End of MedFeaturePrice by Mediacom87-->
