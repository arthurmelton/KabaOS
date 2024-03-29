const c = @import("main.zig").c;
const std = @import("std");
const window = @import("main.zig").global_window;

pub fn page_update(forward: bool) void {
    if (forward) {
        window.index += 1;
    } else {
        window.index -= 1;
    }

    if (window.index == window.functions.len) {
        std.process.exit(0);
    }

    if (window.index > 0) {
        c.gtk_widget_show(@ptrCast(window.back));
    } else {
        c.gtk_widget_hide(@ptrCast(window.back));
    }

    if (window.index < window.functions.len - 1) {
        c.gtk_widget_show(@ptrCast(window.next));
        c.gtk_widget_hide(@ptrCast(window.finish));
    } else {
        c.gtk_widget_hide(@ptrCast(window.next));
        c.gtk_widget_show(@ptrCast(window.finish));
    }

    window.functions[window.index](forward);
}
