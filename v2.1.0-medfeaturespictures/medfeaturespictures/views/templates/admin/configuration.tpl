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

<form class="form-horizontal" method="post" action="{$form_url|escape:'quotes':'UTF-8'}" id="medConfForm">

    <ps-tabs position="left">

        <ps-tab label="{l s='Display' mod='medfeaturespictures'}" active="true" id="tab15-1" icon="icon-desktop" fa="desktop" panel="false">

            <ps-panel icon="icon-desktop" fa="desktop" header="{l s='Display' mod='medfeaturespictures'}">

                <ps-switch on-switch="displayTitleBlock" name="DISPLAY_TITLE" label="{l s='Display a title for this block' mod='medfeaturespictures'}" yes="{l s='Yes' mod='medfeaturespictures'}" no="{l s='No' mod='medfeaturespictures'}" active={if $config.DISPLAY_TITLE}true{else}false{/if} help="{l s='Display a title above your images.' mod='medfeaturespictures'}"></ps-switch>

                <ps-input-text-lang style="display: none" id="blocktitletext" name="blocktitletext" label="{l s='Title' mod='medfeaturespictures'}" help="{l s='You can customize the title for this block' mod='medfeaturespictures'}" size="100" col-lg="7" active-lang="{$id_active_lang|escape:'html':'UTF-8'}">

                    {foreach from=$languages item=language}

                        <div data-is="ps-input-text-lang-value" iso-lang="{$language.iso_code|escape:'html':'UTF-8'}" id-lang="{$language.id_lang|escape:'html':'UTF-8'}" lang-name="{$language.name|escape:'html':'UTF-8'}" value="{if isset($config.blocktitletext[$language.id_lang]) && $config.blocktitletext[$language.id_lang]}{$config.blocktitletext[$language.id_lang]|escape:'html':'UTF-8'}{/if}" placeholder="{l s='Data sheet' mod='medfeaturespictures'}"></div>

                    {/foreach}

                </ps-input-text-lang>

                <ps-panel-divider></ps-panel-divider>

                <h4>{l s='Display feature value' mod='medfeaturespictures'}</h4>

                <ps-switch name="UNDER_PIX" label="{l s='Under the image' mod='medfeaturespictures'}" yes="{l s='Yes' mod='medfeaturespictures'}" no="{l s='No' mod='medfeaturespictures'}" active={if isset($config.UNDER_PIX) && $config.UNDER_PIX}true{else}false{/if} help="{l s='Show the value of the feature as text below the image.' mod='medfeaturespictures'}"></ps-switch>

                <ps-switch name="TOOLTIP" label="{l s='Tooltip' mod='medfeaturespictures'}" yes="{l s='Yes' mod='medfeaturespictures'}" no="{l s='No' mod='medfeaturespictures'}" active={if isset($config.TOOLTIP) && $config.TOOLTIP}true{else}false{/if} help="{l s='Display the value of the element as text using a Tooltip.' mod='medfeaturespictures'}"></ps-switch>

                <ps-panel-divider></ps-panel-divider>

                <h4>{l s='Number of feature per line' mod='medfeaturespictures'}</h4>

                <ps-form-group name="NB_PRODUCTS_XS" label="{l s='Extra small devices Phones' mod='medfeaturespictures'} (<768px)">

                    <select name="NB_PRODUCTS_XS" class="fixed-width-xl">

                        <option value="12"{if $config.NB_PRODUCTS_XS == 12} selected="selected"{/if}>1 {l s='feature' mod='medfeaturespictures'}</option>
                        <option value="6"{if $config.NB_PRODUCTS_XS == 6} selected="selected"{/if}>2 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="4"{if $config.NB_PRODUCTS_XS == 4} selected="selected"{/if}>3 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="3"{if $config.NB_PRODUCTS_XS == 3} selected="selected"{/if}>4 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="2"{if $config.NB_PRODUCTS_XS == 2} selected="selected"{/if}>6 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="1"{if $config.NB_PRODUCTS_XS == 1} selected="selected"{/if}>12 {l s='features' mod='medfeaturespictures'}</option>

                    </select>

                </ps-form-group>

                <ps-form-group name="NB_PRODUCTS_SM" label="{l s='Small devices Tablets' mod='medfeaturespictures'} (≥768px)">

                    <select name="NB_PRODUCTS_SM" class="fixed-width-xl">

                        <option value="12"{if $config.NB_PRODUCTS_SM == 12} selected="selected"{/if}>1 {l s='feature' mod='medfeaturespictures'}</option>
                        <option value="6"{if $config.NB_PRODUCTS_SM == 6} selected="selected"{/if}>2 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="4"{if $config.NB_PRODUCTS_SM == 4} selected="selected"{/if}>3 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="3"{if $config.NB_PRODUCTS_SM == 3} selected="selected"{/if}>4 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="2"{if $config.NB_PRODUCTS_SM == 2} selected="selected"{/if}>6 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="1"{if $config.NB_PRODUCTS_SM == 1} selected="selected"{/if}>12 {l s='features' mod='medfeaturespictures'}</option>

                    </select>

                </ps-form-group>

                <ps-form-group name="NB_PRODUCTS_MD" label="{l s='Medium devices Desktops' mod='medfeaturespictures'} (≥992px)">

                    <select name="NB_PRODUCTS_MD" class="fixed-width-xl">

                        <option value="12"{if $config.NB_PRODUCTS_MD == 12} selected="selected"{/if}>1 {l s='feature' mod='medfeaturespictures'}</option>
                        <option value="6"{if $config.NB_PRODUCTS_MD == 6} selected="selected"{/if}>2 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="4"{if $config.NB_PRODUCTS_MD == 4} selected="selected"{/if}>3 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="3"{if $config.NB_PRODUCTS_MD == 3} selected="selected"{/if}>4 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="2"{if $config.NB_PRODUCTS_MD == 2} selected="selected"{/if}>6 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="1"{if $config.NB_PRODUCTS_MD == 1} selected="selected"{/if}>12 {l s='features' mod='medfeaturespictures'}</option>

                    </select>

                </ps-form-group>

                <ps-form-group name="NB_PRODUCTS_LG" label="{l s='Large devices Desktops' mod='medfeaturespictures'} (≥1200px)">

                    <select name="NB_PRODUCTS_LG" class="fixed-width-xl">

                        <option value="12"{if $config.NB_PRODUCTS_LG == 12} selected="selected"{/if}>1 {l s='feature' mod='medfeaturespictures'}</option>
                        <option value="6"{if $config.NB_PRODUCTS_LG == 6} selected="selected"{/if}>2 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="4"{if $config.NB_PRODUCTS_LG == 4} selected="selected"{/if}>3 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="3"{if $config.NB_PRODUCTS_LG == 3} selected="selected"{/if}>4 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="2"{if $config.NB_PRODUCTS_LG == 2} selected="selected"{/if}>6 {l s='features' mod='medfeaturespictures'}</option>
                        <option value="1"{if $config.NB_PRODUCTS_LG == 1} selected="selected"{/if}>12 {l s='features' mod='medfeaturespictures'}</option>

                    </select>

                </ps-form-group>

                <ps-panel-divider></ps-panel-divider>

                <ps-form-group name="URL_DISPLAY" label="{l s='Method of opening links' mod='medfeaturespictures'}" help="{l s='You can display links in a new window or directly in the page produced as a modal window.' mod='medfeaturespictures'}">

                    <select name="URL_DISPLAY" class="fixed-width-xl">

                        <option value="blank"{if $config.URL_DISPLAY == 'blank'} selected="selected"{/if}>{l s='New window' mod='medfeaturespictures'}</option>
                        <option value="modal"{if $config.URL_DISPLAY == 'modal'} selected="selected"{/if}>{l s='Modal window' mod='medfeaturespictures'}</option>
                    </select>

                </ps-form-group>

                <ps-panel-footer>

                    <ps-panel-footer-submit title="{l s='Save' mod='medfeaturespictures'}" icon="process-icon-save" fa="floppy-o" direction="left" name="saveconf"></ps-panel-footer-submit>

                </ps-panel-footer>


            </ps-panel>

        </ps-tab>

        <ps-tab label="{l s='Images' mod='medfeaturespictures'}" id="tab15-2" icon="icon-picture-o" fa="picture-o" panel="false">

            <ps-panel icon="icon-picture-o" fa="picture-o" header="{l s='Images resize' mod='medfeaturespictures'}">

                <ps-alert-hint>

                    <p>{l s='In order to maintain a consistent display of images on your site, you must customize the precise dimensions of these images.' mod='medfeaturespictures'}</p>

                    <p>{l s='The module will resize the images as they are loaded.' mod='medfeaturespictures'}</p>

                    <p>{l s='If the image is smaller than the configured dimension then blank will be added to reach the configured dimension.' mod='medfeaturespictures'}</p>

                    <p>{l s='If the image is larger, it will be reduced to match the configured dimensions.' mod='medfeaturespictures'}</p>

                </ps-alert-hint>

            	<ps-input-text type="number" name="image_width" label="{l s='Width' mod='medfeaturespictures'}" help="{l s='Set the resizing width of the images when they are saved' mod='medfeaturespictures'}" size="20" value="{if isset($config.image_width)}{$config.image_width|escape:'html':'UTF-8'}{/if}" required-input="true" suffix="px" fixed-width="sm"></ps-input-text>

            	<ps-input-text type="number" name="image_eight" label="{l s='Height' mod='medfeaturespictures'}" help="{l s='Set the resizing height of the images when they are saved' mod='medfeaturespictures'}" size="20" value="{if isset($config.image_eight)}{$config.image_eight|escape:'html':'UTF-8'}{/if}" required-input="true" suffix="px" fixed-width="sm"></ps-input-text>

                <ps-alert-hint>

                    <p>{l s='You can turn off this feature by setting zero for each value.' mod='medfeaturespictures'}</p>

                </ps-alert-hint>

                <ps-alert-hint>

                    <p>{l s='The module accepts PNG, JPG and SVG formats.' mod='medfeaturespictures'}</p>

                    <p>{l s='If you load a file in SVG format and have defined a dimension above, then a CSS file will automatically be generated to constrain your images to the desired dimension.' mod='medfeaturespictures'}</p>

                </ps-alert-hint>

                <ps-panel-footer>

                    <ps-panel-footer-submit title="{l s='Save' mod='medfeaturespictures'}" icon="process-icon-save" fa="floppy-o" direction="left" name="saveconf"></ps-panel-footer-submit>
                </ps-panel-footer>

            </ps-panel>

        </ps-tab>

        <ps-tab label="{l s='Location' mod='medfeaturespictures'}" id="tab15-3" icon="icon-location-arrow" fa="location-arrow" panel="false">

            <ps-panel icon="icon-location-arrow" fa="location-arrow" header="Hook">

                <ps-alert-hint>

                    <p>{l s='Some points of attachment may be absent from your template and therefore do not display your images on the product page.' mod='medfeaturespictures'}</p>

                    <p>{l s='You can choose to use the custom point of attachment (the last one in the list) to set exactly the desired location for displaying your images on your product page.' mod='medfeaturespictures'}</p>

                </ps-alert-hint>

                <ps-radios label="Hook" help="{l s='Select where you want to display your features.' mod='medfeaturespictures'}">

                    {if $ps_version >= 1.7}

                        <ps-radio name="hook" value="displayProductAdditionalInfo"{if $config['hook'] == 'displayProductAdditionalInfo'} checked="true"{/if} class="{if $hookinstall.displayProductAdditionalInfo} {/if}">displayProductAdditionalInfo</ps-radio>
                        <ps-radio name="hook" value="displayReassurance"{if $config['hook'] == 'displayReassurance'} checked="true"{/if}>displayReassurance</ps-radio>
                        <ps-radio name="hook" value="displayAfterProductThumbs"{if $config['hook'] == 'displayAfterProductThumbs'} checked="true"{/if}>displayAfterProductThumbs</ps-radio>

                    {else}

                    <ps-radio name="hook" value="HOOK_PRODUCT_ACTIONS"{if $config['hook'] == 'HOOK_PRODUCT_ACTIONS'} checked="true"{/if}>HOOK_PRODUCT_ACTIONS</ps-radio>
                    <ps-radio name="hook" value="HOOK_EXTRA_RIGHT"{if $config['hook'] == 'HOOK_EXTRA_RIGHT'} checked="true"{/if}>HOOK_EXTRA_RIGHT</ps-radio>
                    <ps-radio name="hook" value="HOOK_EXTRA_LEFT"{if $config['hook'] == 'HOOK_EXTRA_LEFT'} checked="true"{/if}>HOOK_EXTRA_LEFT</ps-radio>
                    <ps-radio name="hook" value="HOOK_PRODUCT_FOOTER"{if $config['hook'] == 'HOOK_PRODUCT_FOOTER'} checked="true"{/if}>HOOK_PRODUCT_FOOTER</ps-radio>

                    {/if}

                    <ps-radio name="hook" value="hookMedFeaturesPictures"{if $config['hook'] == 'hookMedFeaturesPictures'} checked="true"{/if}>hookMedFeaturesPictures</ps-radio>

                </ps-radios>

                <ps-alert-hint id="hookMedFeaturesPictures" style="display: none">

                    <p>{l s='By choosing to use the custom hook of this module you must obligatorily add the code below in your template of the product page to display the images.' mod='medfeaturespictures'}</p>

                    <pre>{$hookname|replace:'{':'\{'|replace:'}':'\}'|escape:'htmlall':'UTF-8'}</pre>

                    <p>{l s='You can put this code anywhere on the product page of your template to display your features as images.' mod='medfeaturespictures'}</p>

                </ps-alert-hint>

                <ps-panel-footer>

                    <ps-panel-footer-submit title="{l s='Save' mod='medfeaturespictures'}" icon="process-icon-save" fa="floppy-o" direction="left" name="saveconf"></ps-panel-footer-submit>

                </ps-panel-footer>

            </ps-panel>

        </ps-tab>

    </ps-tabs>

</form>
