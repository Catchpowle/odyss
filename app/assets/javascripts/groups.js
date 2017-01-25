/* global $, Cookies, Clipboard, HandlebarsTemplates */

(() => {
  $(document).on('ready', () => {
    if (Cookies.get('unauthorized')) {
      $('#sign_in_modal').modal('show')
      Cookies.remove('unauthorized')
    }

    $('.datepicker').datepicker({
      format: 'M d, yyyy'
    })

    $('.copy-invite').click(() => {
      new Clipboard('.copy-invite')
    })

    $('.share-button').click(() => {
      window.open(this.href, '', 'left=300,top=200,menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=250,width=600')
      return false
    });

    (() => {
      const url = window.location.pathname
      const id = url.substring(url.lastIndexOf('/') + 1)

      function checkDiscordID () {
        if ($('#group-link-loader').length) {
          setTimeout(function () {
            $.ajax({
              method: 'POST',
              url: '/api',
              data: {query: `{group(id:"${id}") {name discord_id }}`}
            }).done((msg) => {
              const discordID = msg.data.group.discord_id

              if (discordID) {
                $('#group-link').fadeOut('slow', () => {
                  $('#group-link').html(HandlebarsTemplates['groups/discord_link']({discordID: discordID}))
                  $('#group-link').fadeIn('slow')
                })
                if ($('.alert').length) {
                  $('.alert').fadeOut('slow', () => {
                    $(HandlebarsTemplates['flashes/discordChat']()).hide().prependTo('#main').fadeIn(1000)
                  })
                } else {
                  $(HandlebarsTemplates['flashes/discordChat']()).hide().prependTo('#main').fadeIn(1000)
                }
              } else {
                checkDiscordID()
              }
            })
          }, 3000)
        }
      }
      checkDiscordID()
    })()
  })
})()
