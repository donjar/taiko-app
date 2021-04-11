function getSongsFromCurrentPage() {
  const contentBoxes = $(".contentBox");
  return [...Array(contentBoxes.length).keys()].flatMap((idx) => {
    const contentBox = contentBoxes[idx];
    const [songNameArea, buttonArea] = contentBox.children;

    const title = $.trim(songNameArea.textContent);

    const button = buttonArea.children[0].children[0].children[0];
    if (button === undefined) {
      // Ura oni, no button
      return [];
    }

    const songId = (new URL(button.href)).searchParams.get("song_no");
    return [`${title},${songId}`];
  }).join("\n");
}

function getUraSongsFromCurrentPage() {
  const contentBoxes = $(".contentBox");
  return [...Array(contentBoxes.length).keys()].flatMap((idx) => {
    const buttonChildren = contentBoxes[idx].children[1].children[0].children;
    return (buttonChildren[0].children.length === 0) ? [new URL(buttonChildren[3].children[0].href).searchParams.get("song_no")] : [];
  }).join(",");
}
