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

function getSongs() {
  return [...Array(8).keys()].map((idx) => {
    window.location = `https://donderhiroba.jp/score_list.php?genre=${idx + 1}`;
    while (document.readyState !== "interactive") {};
    return getSongsFromCurrentPage();
  });
}
