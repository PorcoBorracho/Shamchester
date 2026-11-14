// Menú desplegable en móvil
(() => {
  const topBar = document.getElementById('top');
  const burger = document.getElementById('burger');
  if (!topBar || !burger) return;
  burger.addEventListener('click', () => {
    const open = topBar.classList.toggle('open');
    burger.setAttribute('aria-expanded', open);
  });
})();
