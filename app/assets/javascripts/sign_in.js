function togglePassword() {
  const passwordInput = document.getElementById('user_password');
  const toggleButton = document.getElementById('toggle-password');

  if (!passwordInput || !toggleButton) {
    console.error("Elemento non trovato: passwordInput o toggleButton");
    return;
  }

  if (passwordInput.type === 'password') {
    passwordInput.type = 'text';
    toggleButton.textContent = 'Nascondi';
  } else {
    passwordInput.type = 'password';
    toggleButton.textContent = 'Mostra';
  }
}

function toggleConfirmPassword() {
  const passwordInput = document.getElementById('user_password_confirmation');
  const toggleButton = document.getElementById('toggle-confirm-password');

  if (!passwordInput || !toggleButton) {
    console.error("Elemento non trovato: passwordInput o toggleButton");
    return;
  }

  if (passwordInput.type === 'password') {
    passwordInput.type = 'text';
    toggleButton.textContent = 'Nascondi';
  } else {
    passwordInput.type = 'password';
    toggleButton.textContent = 'Mostra';
  }
}

document.addEventListener('DOMContentLoaded', () => {
  console.log("DOM completamente caricato");

  const showPasswordButton = document.getElementById('toggle-password');
  const showConfirmPasswordButton = document.getElementById('toggle-confirm-password');

  if (showPasswordButton) {
    console.log("Pulsante 'Mostra' per la password trovato");
    showPasswordButton.addEventListener('click', togglePassword);
  } else {
    console.error("Pulsante 'Mostra' per la password non trovato");
  }

  if (showConfirmPasswordButton) {
    console.log("Pulsante 'Mostra' per la conferma password trovato");
    showConfirmPasswordButton.addEventListener('click', toggleConfirmPassword);
  } else {
    console.error("Pulsante 'Mostra' per la conferma password non trovato");
  }
});