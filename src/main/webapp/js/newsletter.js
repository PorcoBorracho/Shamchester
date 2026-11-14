// Maqueta: valida el correo y simula el envío. No envía nada al servidor.
// Los textos vienen de messages.properties a través de los data-* del formulario.
(() => {
  const form = document.getElementById('newsForm');
  if (!form) return;
  const email = document.getElementById('email');
  const msg = document.getElementById('newsMsg');
  const btn = document.getElementById('newsBtn');
  email.addEventListener('input', () => { email.removeAttribute('aria-invalid'); msg.textContent = ''; msg.className = 'msg'; });
  form.addEventListener('submit', e => {
    e.preventDefault();
    const v = email.value.trim();
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v)) {
      email.setAttribute('aria-invalid', 'true');
      msg.className = 'msg err';
      msg.textContent = v ? form.dataset.errorInvalid : form.dataset.errorEmpty;
      email.focus();
      return;
    }
    btn.disabled = true;
    btn.querySelector('.spinner').hidden = false;
    btn.querySelector('.lbl-t').textContent = form.dataset.sending;
    setTimeout(() => { form.hidden = true; document.getElementById('newsDone').hidden = false; }, 800);
  });
})();
