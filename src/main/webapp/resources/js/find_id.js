document.addEventListener("DOMContentLoaded", () => {
    const emailInput = document.getElementById("emailInput");
    const phoneInput = document.getElementById("phoneInput");
    const radios = document.querySelectorAll('input[name="auth"]');
  
    radios.forEach((radio) => {
      radio.addEventListener("change", () => {
        if (radio.value === "email") {
          emailInput.style.display = "block";
          phoneInput.style.display = "none";
        } else {
          emailInput.style.display = "none";
          phoneInput.style.display = "block";
        }
      });
    });
  });
  