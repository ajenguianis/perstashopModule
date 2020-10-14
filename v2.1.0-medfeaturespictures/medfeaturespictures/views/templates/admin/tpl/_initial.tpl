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

    <p>{l s='Only characteristics with values are displayed' mod='medfeaturespictures'}</p>
    <p>{l s='You can add a characteristic and return to this page to personalize her.' mod='medfeaturespictures'}</p>
    <p><a href="{$url_manager|escape:'html':'UTF-8'}" class="btn btn-info">{l s='Manage characteristics' mod='medfeaturespictures'}</a></p>

</ps-alert-hint>

<ps-table header="{l s='Characteristics' mod='medfeaturespictures'}" content="{$data|replace:'{':'\{'|replace:'}':'\}'|escape:'htmlall':'UTF-8'}" no-items-text="{l s='No items found' mod='medfeaturespictures'}"></ps-table>