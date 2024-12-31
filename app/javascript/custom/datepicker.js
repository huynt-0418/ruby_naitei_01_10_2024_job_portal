document.addEventListener('turbo:load', () => {
  flatpickr('.flatpickr', {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
    allowInput: true,
  });
});
