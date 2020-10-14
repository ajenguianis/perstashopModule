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

<ps-alert-hint>

    <p>{l s='You can add a value and return on this page to personalize it.' mod='medfeaturespictures'}</p>
    <p><a href="{$url_manager|escape:'html':'UTF-8'}" class="btn btn-info">{l s='Add Feature Value' mod='medfeaturespictures'}</a></p>

</ps-alert-hint>


<ps-table header="{$feature_name|escape:'htmlall':'UTF-8'}" content="{$data|replace:'{':'\{'|replace:'}':'\}'|escape:'htmlall':'UTF-8'}" no-items-text="{l s='No items found' mod='medfeaturespictures'}"></ps-table>

<ps-panel-footer>

    <ps-panel-footer-link title="{l s='Return' mod='medfeaturespictures'}" icon="icon-arrow-circle-left" fa="fa-arrow-circle-left" direction="right" href="{$form_url|escape:'quotes':'UTF-8'}"></ps-panel-footer-link>

</ps-panel-footer>
