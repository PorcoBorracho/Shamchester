// Modal con el vídeo de YouTube del partido
(() => {
  const modal = document.getElementById('video-modal');
  if (!modal || typeof modal.showModal !== 'function') return;
  const frame = modal.querySelector('.video-modal__frame');
  const title = modal.querySelector('#video-modal-title');
  const panel = modal.querySelector('.video-modal__panel');
  let trigger = null;
  let closeTimer = 0;

  const open = (btn) => {
    const id = btn.dataset.videoId;
    if (!/^[\w-]{11}$/.test(id)) return;
    trigger = btn;
    clearTimeout(closeTimer);
    modal.classList.remove('is-closing');
    title.textContent = btn.dataset.videoTitle || '';

    const iframe = document.createElement('iframe');
    iframe.src = 'https://www.youtube-nocookie.com/embed/' + id + '?autoplay=1&rel=0&playsinline=1';
    iframe.title = btn.dataset.videoTitle || 'YouTube';
    iframe.allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share';
    iframe.allowFullscreen = true;
    iframe.referrerPolicy = 'strict-origin-when-cross-origin';
    frame.replaceChildren(iframe);

    modal.showModal();
    document.body.classList.add('modal-open');
    // fuerza el estado inicial antes de animar
    requestAnimationFrame(() => requestAnimationFrame(() => modal.classList.add('is-open')));
  };

  const finish = () => {
    modal.classList.remove('is-closing');
    if (modal.open) modal.close();
    frame.replaceChildren(); // detiene la reproducción
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
    const btn = e.target.closest('.js-video');
    if (btn) open(btn);
  });
  modal.querySelector('[data-close]').addEventListener('click', close);
  // Escape: animamos el cierre en vez del cierre instantáneo nativo
  modal.addEventListener('cancel', (e) => { e.preventDefault(); close(); });
  // clic fuera del panel
  modal.addEventListener('click', (e) => { if (!panel.contains(e.target)) close(); });
})();
