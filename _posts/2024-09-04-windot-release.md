---
layout: post
title: "Release 0.1.0 of `windot` is here! Here's how you can try it out."
date: 2024-09-04 15:01:00 -0400
categories: code linux
description: "Announcing the release of version 0.1.0 of `windot`, an emoji picker for Linux systems."
---

So it's been a while since I actually came close to being done with a project, but I've finally made something worth using again!

## What is it?

If you're running Linux and are in search of a decent emoji picker, consider using [windot][windot]! I just decided to finally release version `0.1.0` today after a long time of no updates to the codebase. It's a simple GTK application that opens up, waits for you to pick an emoji, copies it to the clipboard, and closes again. It does one thing and does it well.

---

Here's a little bit of a preview of what it looks like:

![Hello, world!](/assets/img/windot/main.png)

---

## Installation

I haven't uploaded binaries to any distro package repos myself, but I might someday. In the meantime, if anyone else would like to, that would be great too!

To build from source, it requires a bunch of dependencies. Copy and run a line from below based on your distro:

```bash
# Arch Linux
sudo pacman -S --needed gcc gtk4 pkgconf libadwaita

# Ubuntu
sudo apt install gcc libgtk-4-dev pkg-config libadwaita-1-dev
```

If your distro is missing from this list and you figure out what the dependency package names are, please let me know so I can add them here for others to see. Once you have the dependencies installed, build the crate from crates.io with:

```bash
cargo install windot
```

---

## Usage

Once you have it installed, run the `windot` command in your terminal and make sure it works as expected. If it does, you can add it to your desktop environment's shortcuts registry and make some keybind like <kbd>Win</kbd>+<kbd>.</kbd> (get it? win and dot? 😅) to open it up quickly whenever you need it.

To pick a skin color for an emoji, you can right click on the emoji to switch to a preview of skin tones. The settings page also has an option for you to set a default skin tone, along with clearing your recent emojis.

![Settings](/assets/img/windot/settings.png)

---

## Looking Ahead

This is only the first release, and although I haven't found any bugs myself in daily use, it's still probably not perfect. File an [issue][issues] if you find a bug or have a feature request.

EDIT: As I was writing this post, I found and fixed [a small bug](https://github.com/Lamby777/windot/issues/6). So, yeah, it's not perfect. 😆

### Clipboard Issues?

My friend ran into a problem with the emojis not being saved to their clipboard manager. They were using `klipper` from KDE, and if I remember correctly, managed to get some fix working on their local copy. It may be ready soon, or it may not. I have no idea. Regardless, keep in mind that systems using `klipper` as the clipboard manager might not run `windot` properly for now.

### Direct Typing

One feature you might notice is missing is the ability to click an emoji to type it directly into a text field. This is something I really miss from Windows, where typing emojis is fairly straightforward and doesn't involve the clipboard at all. All the other emoji pickers I've seen on Linux don't have it either. This is the only real feature left to add, so it's my main focus for the app right now.

### App Icon

Right now, it just shows the Wayland default icon in the taskbar. I'd like to add a custom icon for the app, but I'm not sure how to do that yet. I'll look into it soon.

---

## Nerd Stuff

<em>
  Shadowing is different from marking a variable as `mut` because we’ll get a compile-time error if we accidentally try to reassign to this variable without using the `let` keyword. By using `let`, we can perform a few transformations on a value but have the variable be immutable after those transformations have been completed.
</em>

Alright, are the non-nerds gone yet? Nice. 😆

### [`emojis`][emojis-crate]

I actually really enjoyed making this project because of this one crate. It provides a way to iterate over every single emoji in the unicode standard, along with some types for working with emojis. Iterators are my favorite part of working on Rust code! 😄

The guy who made it was very quick to add `serde` support as well when I asked about it and gave a use case (preferred skin tone serialization), so it's clearly still being looked at and stuff. Here's an example of some code referencing the crate, which gets a list of every single emoji, including skin tone variants.

```rust
fn every_emoji_and_variants() -> impl Iterator<Item = &'static Emoji> {
    emojis::iter().flat_map(|e| {
        let tones = e.skin_tones();
        let default = std::iter::once(e);

        let mut tones_only = tones.into_iter().flatten();
        tones_only.next();

        default.chain(tones_only)
    })
}
```

### [`gtk4`][gtk4-crate]

Having absolutely zero knowledge on how to write a GTK app before starting this project, it was pretty interesting to see how the people behind this crate managed to turn GTK's inheritance-based object-oriented design into something that still works intuitively in Rust. It really reminds me of the [`gdext`](https://github.com/godot-rust/gdext/) project, in the sense that you can cast between types and that sort of stuff. It's pretty cool. I had no issues specifically with the crate, and if you're thinking of writing a simple GUI application in Rust, I'd highly recommend it, along with bookmarking the GTK [Widget Gallery](https://docs.gtk.org/gtk4/visual_index.html) in your browser. It's like a visual documentation page for any GTK UI component you'd like to code up into your app.

---

## Conclusion

I hope you enjoy using `windot` for all your emoji-picking needs as much as I enjoyed working on it so far. I'm excited to see what the community thinks of it and what features they'd like to see next. Again, if you have any ideas, feel free to open an issue on the [GitHub repo][issues]!

---

## Updates

2024-09-05: I found out that in order to have a custom icon for the app, I need to create a `.desktop` file and install it to the right place. This means I need to learn how to package the app properly for different distros or offer a Flatpak/AppImage. I'll look into it soon.

[windot]: https://github.com/Lamby777/windot
[issues]: https://github.com/Lamby777/windot/issues
[emojis-crate]: https://crates.io/crates/emojis
[gtk4-crate]: https://crates.io/crates/gtk4
