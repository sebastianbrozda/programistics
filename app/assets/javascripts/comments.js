programistics.comments = (function () {

    var self = {};

    function loadComments() {

    }

    self.init = function (options) {
        $('#comment_form').submit(function (e) {
            e.preventDefault();

            $.post('/comments/create', {note_id: options.note_id, comment_body: $('#comment_body').val()},
                function (resp) {
                    programistics.helpers.alert(resp);
                    if (resp.result) {
                        loadComments();
                    }
                }, "json");
        })
    }


    return self;

})();