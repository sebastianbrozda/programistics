programistics.user_settings = {};
programistics.user_settings = (function () {

    var self = {};

    self.init = function () {
        $('#form_update_email').submit(function (e) {
            e.preventDefault();

            $.post('/update_email/', {email: $('#email').val()}, function (resp) {
                programistics.helpers.alert(resp);
            }, "json");
        });

        $('#form_bitcoin_wallet').submit(function(e){
            e.preventDefault();

            $.post('/update_bitcoin_wallet', {wallet: $('#bitcoin_wallet').val()}, function(resp) {
                programistics.helpers.alert(resp);
            }, "json");
        });
    };

    return self;
})();