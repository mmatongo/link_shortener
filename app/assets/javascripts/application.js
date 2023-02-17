function updateVisitCount(urlId) {
  const url = `/urls/${urlId}/visit`;
  const authenticity_token = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content");

  fetch(url, {
    method: "POST",
    headers: {
      "X-CSRF-Token": authenticity_token,
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    credentials: "same-origin",
  })
    .then((response) => response.json())
    .then((data) => {
      const visitCountEls = document.querySelectorAll(`#visit-count-${urlId}`);
      visitCountEls.forEach((el) => {
        el.innerHTML = data.visitCount;
      });
    })
    .catch((error) => console.error(error));
}
