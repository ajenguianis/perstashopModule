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

<form class="form-horizontal" method="post" action="{$form_url|escape:'quotes':'UTF-8'}" enctype="multipart/form-data">

    <h2>{$f_name|escape:'htmlall':'UTF-8'} : {$feature_value_name|escape:'htmlall':'UTF-8'}</h2>

    <ps-tabs position="left">

        <ps-tab label="{l s='Images' mod='medfeaturespictures'}" active="true" id="tab2-1" icon="icon-picture-o" fa="picture-o">

            <ps-tabs position="top">

            {foreach from=$languages item=lang name=langue}

                <ps-tab label="{$lang.name|escape:'html':'UTF-8'}" flag="../img/l/{$lang.id_lang}.jpg" {if $smarty.foreach.langue.first}active="true"{/if} id="tab2-1-{$smarty.foreach.langue.iteration}"{if $smarty.foreach.langue.total == 1} panel="false"{/if}>

                    {if $smarty.foreach.langue.total == 1}

                    <h4>{$lang.name|escape:'html':'UTF-8'}</h4>

                    {/if}

                    <ps-form-group name="picture" label="{if $images[$lang.iso_code]|escape:'html':'UTF-8'}{l s='Replace image' mod='medfeaturespictures'}{else}{l s='New image' mod='medfeaturespictures'}{/if}">

                        {$image_uploader.{$lang.iso_code}}

                    </ps-form-group>

                    {if $smarty.foreach.langue.first && $smarty.foreach.langue.total > 1}

                    <ps-checkboxes>

                    	<ps-checkbox name="same_image" value="1">{l s='Use this image loaded on all other languages' mod='medfeaturespictures'}</ps-checkbox>

                    </ps-checkboxes>

                    {/if}

                    <ps-panel-footer>

                        <ps-panel-footer-submit title="{l s='Save' mod='medfeaturespictures'}" icon="process-icon-save" fa="floppy-o" direction="left" name="savepicture"></ps-panel-footer-submit>

                        <ps-panel-footer-link title="{l s='Return' mod='medfeaturespictures'}" icon="icon-arrow-circle-left" fa="fa-arrow-circle-left" direction="right" href="{$form_url|escape:'quotes':'UTF-8'}&action={$back_action|escape:'htmlall':'UTF-8'}&id_feature={$id_feature|escape:'htmlall':'UTF-8'}"></ps-panel-footer-link>

                    </ps-panel-footer>

                </ps-tab>

            {/foreach}

            </ps-tabs>

        </ps-tab>

        <ps-tab label="{l s='Link to a CMS page' mod='medfeaturespictures'}" id="tab2-2" icon="icon-cogs" fa="cogs">

            <ps-form-group name="id_cms" label="{l s='Associate a CMS page' mod='medfeaturespictures'}" help="{if $config.URL_DISPLAY == 'modal'}{l s='You can display links in the page produced as a modal window.' mod='medfeaturespictures'}{else}{l s='You can display links in a new window.' mod='medfeaturespictures'}{/if}">

                <select name="id_cms" class="fixed-width-xl">

                    <option value="9999999999"{if !isset($config.ID_CMS[$id_feature_value])} selected="selected"{/if}>{l s='No CMS page link' mod='medfeaturespictures'}</option>

                    {foreach from=$cms_pages item=cms}

                    <option value="{$cms.id_cms|escape:'htmlall':'UTF-8'}"{if isset($config.ID_CMS[$id_feature_value]) && $config.ID_CMS[$id_feature_value] == $cms.id_cms} selected="selected"{/if}>{$cms.meta_title|escape:'htmlall':'UTF-8'}</option>

                    {/foreach}

                </select>

            </ps-form-group>

            <ps-panel-footer>

                <ps-panel-footer-submit title="{l s='Save' mod='medfeaturespictures'}" icon="process-icon-save" fa="floppy-o" direction="left" name="savepicture"></ps-panel-footer-submit>

                <ps-panel-footer-link title="{l s='Delete' mod='medfeaturespictures'}" icon="icon-trash" fa="fa-trash" direction="right" href="{$form_url|escape:'quotes':'UTF-8'}&del_picture={$id_feature_value|escape:'htmlall':'UTF-8'}&iso_code={$lang.iso_code|escape:'htmlall':'UTF-8'}&action=edit_picture&back_action={$back_action|escape:'htmlall':'UTF-8'}&id_feature={$id_feature|escape:'htmlall':'UTF-8'}&id_feature_value={$id_feature_value|escape:'htmlall':'UTF-8'}"></ps-panel-footer-link>

                <ps-panel-footer-link title="{l s='Cancel' mod='medfeaturespictures'}" icon="icon-arrow-circle-left" fa="fa-arrow-circle-left" direction="right" href="{$form_url|escape:'quotes':'UTF-8'}&action={$back_action|escape:'htmlall':'UTF-8'}&id_feature={$id_feature|escape:'htmlall':'UTF-8'}"></ps-panel-footer-link>

            </ps-panel-footer>

        </ps-tab>


    </ps-tabs>

    <input type="hidden" name="id_feature_value" value="{$id_feature_value|escape:'htmlall':'UTF-8'}">

    <input type="hidden" name="id_feature" value="{$id_feature|escape:'htmlall':'UTF-8'}">

    <input type="hidden" name="action" value="{$back_action|escape:'htmlall':'UTF-8'}">

</form>