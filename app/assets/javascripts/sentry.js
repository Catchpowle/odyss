/* global $, Raven */

(() => {
  $(document).on('ready', () => {
    Raven.config('https://f272bc50fcc34ccd8b981ae48821376b@sentry.io/132863').install()
  })
})()
