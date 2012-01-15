$(document).ready(function() {
    var lend_form = $("#lend-form");
    var borrow_form = $("#borrow-form");
    var INVALID = "invalid";

    // hide our forms before the user clicks the buttons, and disable
    // the submit buttons
    var init = function() {
        lend_form.hide();
        borrow_form.hide();
    };

    init();
    
    // action performed when user clicks lend button
    // The form box will expand during this action
    $("#lend").click(function() {
        lend_form.fadeIn();
        borrow_form.hide();
    });

    // borrow form box expands when user clicks borrow button
    $("#borrow").click(function() {
        borrow_form.fadeIn();
        lend_form.hide();
    });

    // When the user submits the form, validate input first
    /*
    $("#lend-submit").click(function(e) {
        var lend_friend, lend_item;
        lend_friend     = $("#lend-form .chzn-select");
        lend_item_name  = $("#lend-item-name"        );
        lend_item_value = $("#lend-item-value"       );

        lend_friend.removeClass(INVALID);
        lend_item_name.removeClass(INVALID);
        lend_item_value.removeClass(INVALID);

        if (lend_friend.val() === "") {
            lend_friend.addClass(INVALID);
            e.preventDefault();
            return;
        }

        if (lend_item_name.val() === "") {
            lend_item_name.addClass(INVALID);
            e.preventDefault();
            return;
        }

        if (lend_item_value.val() === "") {
            lend_item_value.addClass(INVALID);
            e.preventDefault();
            return;
        }
    });

    $("#borrow-submit").click(function(e) {
        var borrow_item = $("#borrow-item");

        if (borrow_item.val() === "") {
            borrow_item.addClass(INVALID);
            e.preventDefault();
            return;
        }

        borrow_item.removeClass(INVALID);
    }); */
});
