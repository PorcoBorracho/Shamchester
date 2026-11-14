// Cuenta atrás al próximo partido. La fecha viene del .env (NEXT_MATCH_DATE).
(() => {
  const el = document.getElementById('countdown');
  if (!el) return;
  const kickoff = new Date(el.dataset.kickoff);
  if (isNaN(kickoff)) return;
  const set = (u, v) => { el.querySelector(`[data-u="${u}"]`).textContent = String(v).padStart(2, '0'); };
  function tick() {
    let t = Math.max(0, kickoff - new Date());
    const d = Math.floor(t / 864e5); t -= d * 864e5;
    const h = Math.floor(t / 36e5); t -= h * 36e5;
    const m = Math.floor(t / 6e4); t -= m * 6e4;
    set('d', d); set('h', h); set('m', m); set('s', Math.floor(t / 1e3));
  }
  tick();
  setInterval(tick, 1000);
})();
