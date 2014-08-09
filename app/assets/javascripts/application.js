// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
//= require_tree .

programistics.helpers = (function () {
    var self = {};

    self.alert = function (resp, target) {
        var msg = $.isArray(resp.msg) ? resp.msg.join('<br/>') : resp.msg;
        var cssClass = resp.result ? 'success' : 'danger';

        var alertId = "alert-" + (new Date().getTime());


        if (typeof target === "undefined") {
            target = $('#content .container .row').first();
        }

        target.prepend('<div id="' + alertId + '" class="alert alert-' + cssClass + '">' + msg + '</div>');

        setTimeout(function () {
            $('#' + alertId).fadeOut('slow')
        }, 5000);

    };

    return self;
})();