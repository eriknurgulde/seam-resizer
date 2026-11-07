# Seam Resizer

**Content-aware image resizing you can drag, live.** Shrink, enlarge, extend one side or crop a picture. The plain parts (sky, sea, walls, background) are stretched or removed, and the important objects keep their shape.

It's a single HTML file that runs entirely in your web browser. There's nothing to install, no account, no internet needed, and your images never leave your computer.

**▶ Try it online:** https://eriknurgulde.github.io/seam-resizer/

---

## What it does

| Feature | What it means |
|---|---|
| **Resize (shrink & enlarge)** | Drag the Width and Height sliders from 20% to 180%. It removes or duplicates the least important lines of pixels ("seams"), so people and objects aren't squashed or stretched. |
| **Exact size** | Type the width and height in pixels (or how many pixels to add in Extend side) instead of dragging. |
| **Lock proportions** | Width and height change together, so the picture keeps its shape. |
| **Extend side** | Grow the picture on one side only (left, right, top or bottom). Everything else stays exactly where it was. |
| **Crop** | Drag a box with handles. Presets: Free, Original, 1:1, 4:5, 4:3, 3:2, 16:9, 9:16, or type an exact size. |
| **Protect / Remove marks** | Paint over things that must keep their shape (Protect) or that you want removed first (Remove). Marks follow the image through every step. |
| **3×3 grid** | Rule-of-thirds overlay so you can see where your subject sits. |
| **See what's happening** | Highlight the seams being removed or added, animate the resize, or compare with a normal (squashed) resize. |
| **Keep result & continue** | Use the current result as the new starting image to chain steps, e.g. crop, then extend, then resize. |
| **Download PNG** | Save the result. |

---

## How to install

You only need a modern browser: Chrome, Edge, Firefox or Safari.

### Option 1: use it online (nothing to download)
Open **https://eriknurgulde.github.io/seam-resizer/** and bookmark it. Everything still runs on your own computer; images are not uploaded anywhere.

### Option 2: download it and use it offline
1. On this page, click the green **Code** button, then **Download ZIP**.
2. Unzip it anywhere, for example in your Documents folder.
3. Double-click **`seam-resizer.html`**. It opens in your browser.

### Option 3 (Windows): add a Desktop shortcut that opens it like an app
After Option 2, double-click **`install-shortcut.cmd`** in the unzipped folder. It creates:
- a **Seam Resizer** icon on your Desktop,
- a **Seam Resizer** entry in the Start menu,
- the keyboard shortcut **Ctrl + Alt + R**.

They open the tool full-screen in its own window, without browser tabs. If Windows shows a "Windows protected your PC" message, click **More info → Run anyway**. The script only creates shortcuts, and you can read it in `install-shortcut.ps1`.

Don't move the folder after creating the shortcut. If you do, run `install-shortcut.cmd` again.

---

## How to use it

1. **Load a picture:** click **Open image…**, drag a file onto the page, paste one with **Ctrl+V**, or click **Try a sample**.
2. **Wait a few seconds** while the orange bars under the sliders fill up. This is the analysis. You can drag before it finishes; the slider just catches up.
3. Pick a mode at the top of the **Size** section:
   - **Resize:** drag **Width** and **Height** (left shrinks, right enlarges), or type exact pixels in the **Exact size** boxes and press Enter.
   - **Extend side:** pick a side, then drag **Add** or type the number of pixels to add. **Fill from the outer…** sets how wide the edge area is that gets stretched. Make it larger to add more, or smaller if something near the edge gets stretched.
   - **Crop:** drag the box or its handles, or pick a ratio, then click **Apply crop** (or press Enter).
4. **If something gets distorted:** under **Mark areas**, choose **Protect**, paint over it, and click **Done marking**.
5. **Download PNG** saves the result.

### Tips
- Works best on photos with **plain areas** like sky, sea, sand, walls or studio backgrounds. Busy images with detail everywhere can look warped.
- For big changes, do two smaller steps with **Keep result & continue editing**. This usually looks better than one big step.
- **Working size** sets how big an image the tool works on. Larger is sharper but slower. The default is 900 px on the longest side, so very large photos are scaled down. Choose *Detailed* or *Large* for bigger output.

---

## How it works

The tool uses **seam carving** (Avidan & Shamir, 2007). For each image it calculates how "important" every pixel is from how sharply the colour changes around it. It then repeatedly finds the connected line of pixels from top to bottom with the lowest total importance (a *seam*):
- To **shrink**, those seams are removed.
- To **enlarge**, the same seams are duplicated.
- To **extend one side**, seams are only allowed near that edge, so nothing else moves.

The whole order of seams is calculated once in the background (a Web Worker). That's why the sliders can update instantly.

The idea is inspired by the command-line tool [Caire](https://github.com/esimov/caire). This project is an independent browser implementation and contains no Caire code.

---

## Browser support

Tested in Microsoft Edge and Google Chrome on Windows. It should also work in any recent Firefox or Safari.

## License

[MIT](LICENSE): free to use, copy, modify and share.
