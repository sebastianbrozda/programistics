programistics.notes = {};
programistics.notes = (function () {

    var form = {};
    form.init = function () {

        $('#note_note_type_id').change(function () {
            switch (parseInt($(this).val())) {
                case programistics.config.NOTE_TYPE_PAID_ACCESS:
                    $('#app-price-panel').show();
                    break;
                default:
                    $('#app-price-panel').hide();
                    break;
            }
        });
        $('#note_note_type_id').trigger('change');
    };

    var show = {};
    show.init = function (opts) {
        $('#app-purchase-btn').click(function () {
            window.location.href = '/purchase/note/' + opts.note_param;
            return false;
        });
    };

    return  {
        form: form,
        show: show
    };

})();

