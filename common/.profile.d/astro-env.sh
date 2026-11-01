# Astro CLI environment
#
# Astro is intentionally NOT installed globally — it's a per-project
# devDependency (see npm-env.sh for the Node 22 PATH setup that lets
# `npm run dev` / `npx astro` resolve node/npm at all). This just sets a
# shared preference: disable Astro's anonymous telemetry for any project's
# local astro invocation.

export ASTRO_TELEMETRY_DISABLED=1
