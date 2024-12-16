document.addEventListener("turbo:load", function () {
  document.querySelectorAll("[id^='applyJobModal']").forEach(modal => {
    const modalId = modal.id;
    const step1 = modal.querySelector("#step1");
    const step2 = modal.querySelector("#step2");
    const nextStepButton = modal.querySelector(`#nextStep-${modalId.split('-')[1]}`);
    const submitButton = modal.querySelector(`#submitApplication-${modalId.split('-')[1]}`);
    const cvInput = modal.querySelector("#cv_file");
    const progressBar = modal.querySelector(`#progressBar-${modalId.split('-')[1]}`);
    const useExistingCVButton = modal.querySelector(`#useExistingCV-${modalId.split('-')[1]}`);

    nextStepButton.addEventListener("click", function () {
      if (step1.classList.contains("d-none")) {
        step1.classList.remove("d-none");
        step2.classList.add("d-none");
        nextStepButton.textContent = "Next";
        submitButton.classList.add("d-none");

        progressBar.style.width = "50%";
        progressBar.setAttribute("aria-valuenow", 50);
        progressBar.textContent = "Step 1 of 2";

      } else {
        step1.classList.add("d-none");
        step2.classList.remove("d-none");
        nextStepButton.textContent = "Back";
        submitButton.classList.remove("d-none");

        progressBar.style.width = "100%";
        progressBar.setAttribute("aria-valuenow", 100);
        progressBar.textContent = "Step 2 of 2";
      }
    });

    cvInput.addEventListener("change", function () {
      if (submitButton.hasAttribute("disabled")) {
        submitButton.removeAttribute("disabled");
        submitButton.classList.remove("btn-secondary");
        submitButton.classList.add("btn-primary");
      }
    });

    useExistingCVButton.addEventListener("change", function () {
      if (useExistingCVButton.checked){
        if (submitButton.hasAttribute("disabled")) {
          submitButton.removeAttribute("disabled");
          submitButton.classList.remove("btn-secondary");
          submitButton.classList.add("btn-primary");
        }
        cvInput.setAttribute("disabled", true);
      } else {
        cvInput.removeAttribute("disabled");
        if (!cvInput.value) {
          submitButton.setAttribute("disabled", true);
          submitButton.classList.remove("btn-primary");
          submitButton.classList.add("btn-secondary");
        } else {
          submitButton.removeAttribute("disabled");
          submitButton.classList.remove("btn-secondary");
          submitButton.classList.add("btn-primary");
        }
      }
    });
  });
});
