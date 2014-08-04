programistics.comments = (function () {

    var self = {};

    function loadComments(note_id) {
        $.get('/comments/' + note_id, {}, function (html) {
            $('#comment-list').html(html);
        });
    }

    self.init = function (options) {
        $('#comment_form').submit(function (e) {
            e.preventDefault();

            $.post('/comments/create', {note_id: options.note_id, comment_body: $('#comment_body').val()},
                function (resp) {
                    programistics.helpers.alert(resp);
                    if (resp.result) {
                        loadComments(options.note_id);
                    }
                }, "json");
        })
    }


    return self;

})();