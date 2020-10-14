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

<div id="chargement">
    <i class="{if $ps_version >= 1.6}process-icon-refresh icon-spin icon-pulse{else}fa fa-refresh fa-spin fa-pulse clear{/if}"></i> {l s='Loading...' mod='medfeaturespictures'}<span id="chargement-infos"></span>
</div>

<ps-tabs position="top">

    {if !isset($config.image_width) || !isset($config.image_eight)}

    <ps-tab label="{l s='Configuration' mod='medfeaturespictures'}" active="true" id="tab15" icon="icon-cogs" fa="cogs">

        <ps-alert-error>

            <p>{l s='You must configure the size of the images when loading them in order to use the module correctly!' mod='medfeaturespictures'}</p>

        </ps-alert-error>

    {else}

    <ps-tab label="{l s='Features' mod='medfeaturespictures'}" active="true" id="tab10" icon="icon-picture-o" fa="picture-o">

        {include file="$tpl_path/views/templates/admin/tpl/$tplFile"}

    </ps-tab>

    <ps-tab label="{l s='Configuration' mod='medfeaturespictures'}" id="tab15" icon="icon-cogs" fa="cogs">

    {/if}

        {include file="$tpl_path/views/templates/admin/configuration.tpl"}

    </ps-tab>

    <ps-tab label="{l s='Informations' mod='medfeaturespictures'}" id="tab20" icon="icon-info" fa="info">

        {include file="$tpl_path/views/templates/admin/about.tpl"}

    </ps-tab>

    <ps-tab label="{l s='More Modules' mod='medfeaturespictures'}" id="tab25" icon="icon-cubes" fa="cubes">

        {include file="$tpl_path/views/templates/admin/modules.tpl"}

    </ps-tab>

    {if isset($addons_id) && $addons_id}

    <ps-tab label="{l s='Opinion' mod='medfeaturespictures'}" id="tab26" icon="icon-thumbs-up" fa="thumbs-up">

        {include file="$tpl_path/views/templates/admin/rate.tpl"}

    </ps-tab>

    {/if}

    <ps-tab label="{l s='License' mod='medfeaturespictures'}" id="tab30" icon="icon-legal" fa="legal">

        {include file="$tpl_path/views/templates/admin/licence.tpl"}

    </ps-tab>

    <ps-tab label="Changelog" id="tab40" icon="icon-code" fa="code">

        {include file="$tpl_path/views/templates/admin/changelog.tpl"}

    </ps-tab>

</ps-tabs>

<script type="text/javascript">

    $(document).ready(function() {ldelim}

        $.pageLoader();

        $( "td:contains('/pictures/')" ).each(function() {ldelim}
            $( this ).html('<img src="' + $.trim($( this ).text()) + '" class="imgpicto img-responsive" />');
        {rdelim});

        $( "th:contains('../img/l/')" ).each(function() {ldelim}
            $( this ).html('<img src="' + $.trim($( this ).text()) + '" />');
        {rdelim});

        if ($('input[name=hook]:checked').val() == 'hookMedFeaturesPictures') {ldelim}
            $('#hookMedFeaturesPictures').show();
        {rdelim}

        {if $config.DISPLAY_TITLE}
            $('#blocktitletext').show();
        {/if}

        $('#medConfForm input').on('change', function() {ldelim}
           if ($('input[name=hook]:checked').val() == 'hookMedFeaturesPictures') {ldelim}
                $('#hookMedFeaturesPictures').show();
            {rdelim} else {ldelim}
                $('#hookMedFeaturesPictures').hide();
            {rdelim}
        {rdelim});

    {rdelim});

    function displayTitleBlock(status) {ldelim}
        $('#blocktitletext').toggle();
	{rdelim}

</script>