programistics.favorites = {};

programistics.favorites = (function () {

    var self = {};
    var options = {};

    function addNoteToFavorites() {
        var _self = $(this);
        $.post('/favorites/add_note_to_favorites', {note_id: options.note_id}, function (resp) {
            if (resp.result) {
                _self.hide();
                $('#app-remove-note-from-favorites').show();
            }
        }, "json");

        return false;
    }

    function removeNoteFromFavorites() {
        var _self = $(this);
        $.post('/favorites/remove_note_from_favorites', {note_id: options.note_id}, function (resp) {
            if (resp.result) {
                _self.hide();
                $('#app-add-note-to-favorites').show();
            }
        }, "json");

        return false;
    }

    self.init = function (opts) {
        options = opts;

        $('#app-add-note-to-favorites').click(addNoteToFavorites);
        $('#app-remove-note-from-favorites').click(removeNoteFromFavorites);

        if (options.isFavorite) {
            $('#app-add-note-to-favorites').hide();
            $('#app-remove-note-from-favorites').show();
        }
    };


    return self;

})();