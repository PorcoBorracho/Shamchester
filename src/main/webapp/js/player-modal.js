// Modal con las estadísticas globales de un jugador (página Plantel)
(() => {
  const modal = document.getElementById('player-modal');
  if (!modal || typeof modal.showModal !== 'function') return;
  const panel = modal.querySelector('.player-modal__panel');
  const num = modal.querySelector('.player-modal__num');
  const name = modal.querySelector('.player-modal__name');
  const role = modal.querySelector('.player-modal__role');
  const photo = modal.querySelector('.player-modal__photo');
  const radar = modal.querySelector('.player-modal__radar');
  const content = modal.querySelector('.player-modal__content');
  let trigger = null;
  let closeTimer = 0;

  const open = (btn) => {
    const card = btn.closest('.player');
    if (!card) return;
    trigger = btn;
    clearTimeout(closeTimer);
    modal.classList.remove('is-closing', 'is-open');

    num.textContent = btn.dataset.dorsal || '';
    name.textContent = btn.dataset.nombre || '';
    role.textContent = btn.dataset.posicion || '';

    // misma foto y etiquetas que la tarjeta (la imagen ya está en caché)
    const foto = card.querySelector('.photo').cloneNode(true);
    foto.querySelectorAll('img').forEach((img) => { img.loading = 'eager'; img.alt = btn.dataset.nombre || ''; });
    foto.querySelectorAll('[id]').forEach((el) => el.removeAttribute('id'));
    // la silueta SVG tiene que cubrir el hueco igual que una foto (object-fit no aplica a SVG)
    foto.querySelectorAll('svg').forEach((svg) => svg.setAttribute('preserveAspectRatio', 'xMidYMax slice'));
    photo.replaceChildren(foto);

    const radarTpl = card.querySelector('template.js-radar');
    radar.replaceChildren(radarTpl ? radarTpl.content.cloneNode(true) : '');
    // sin datos el template queda solo con espacios: así :empty lo oculta
    if (!radar.querySelector('svg')) radar.replaceChildren();

    const tpl = card.querySelector('template.js-stats');
    content.replaceChildren(tpl ? tpl.content.cloneNode(true) : '');

    modal.showModal();
    document.body.classList.add('modal-open');
    // fuerza el estado inicial antes de animar (también las barras)
    requestAnimationFrame(() => requestAnimationFrame(() => modal.classList.add('is-open')));
  };

  const finish = () => {
    modal.classList.remove('is-closing');
    if (modal.open) modal.close();
    document.body.classList.remove('modal-open');
    if (trigger) trigger.focus();
    trigger = null;
  };

  const close = () => {
    if (!modal.open || modal.classList.contains('is-closing')) return;
    modal.classList.add('is-closing');
    modal.classList.remove('is-open');
    const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    closeTimer = setTimeout(finish, reduce ? 0 : 150);
  };

  document.addEventListener('click', (e) => {
    const btn = e.target.closest('.js-player');
    if (btn) open(btn);
  });
  modal.querySelector('[data-close]').addEventListener('click', close);
  // Escape: cierre animado en vez del instantáneo nativo
  modal.addEventListener('cancel', (e) => { e.preventDefault(); close(); });
  // clic fuera del panel
  modal.addEventListener('click', (e) => { if (!panel.contains(e.target)) close(); });
})();
