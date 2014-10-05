<section id="main">
    <div class="page-header">
        <h2><?= empty($values['is_private']) ? t('New project') : t('New private project') ?></h2>
        <ul>
            <li><?= Helper\a(t('All projects'), 'project', 'index') ?></li>
        </ul>
    </div>
    <section>
    <form method="post" action="<?= Helper\u('project', 'save') ?>" autocomplete="off">

        <?= Helper\form_csrf() ?>
        <?= Helper\form_hidden('is_private', $values) ?>
        <?= Helper\form_label(t('Name'), 'name') ?>
        <?= Helper\form_text('name', $values, $errors, array('autofocus', 'required')) ?>

        <div class="form-actions">
            <input type="submit" value="<?= t('Save') ?>" class="btn btn-blue"/>
            <?= t('or') ?> <?= Helper\a(t('cancel'), 'project', 'index') ?>
        </div>
    </form>
    </section>
</section>