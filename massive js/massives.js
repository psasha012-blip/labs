const blocks = [
    { width: 40, height: 40 },
    { width: 60, height: 80 },
    { width: 80, height: 160 },
    { width: 100, height: 200 }
];
const root = document.createElement("div");
for (let i = 0; i < blocks.length; i++) {
    const block = document.createElement("div");
    block.className = "block";
    block.style.width = blocks[i].width + "px";
    block.style.height = blocks[i].height + "px";
    root.appendChild(block);
}
document.body.appendChild(root);