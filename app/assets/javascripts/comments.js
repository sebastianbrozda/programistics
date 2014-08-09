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
                    programistics.helpers.alert(resp, $('#comment-alert-panel'));
                    if (resp.result) {
                        $('#comment_body').val('');
                        loadComments(options.note_id);
                    }
                }, "json");
        });

        loadComments(options.note_id);
    }


    return self;

})();