programistics.comments = (function () {

    var self = {};

    function loadComments() {

    }

    self.init = function () {
        $('#comment_form').submit(function (e) {
            e.preventDefault();

            $.post('/comments/create', {comment_body: $('#comment_body').val()},
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