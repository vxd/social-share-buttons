#= require jquery
#= require socialAdapters

$ ->
  PLUGIN_NAME = 'socialShareButtons'

  methods =
    init: (options) ->
      settings = $.extend true,
        selectors:
          tw: '.js-tw'
          fb: '.js-fb'
          gp: '.js-gp'
          vk: '.js-vk'
          ok: '.js-ok'
        containerSelector: '.socials-share-buttons-container'
        url: location.href
        isInitScroller: false
      , options

      @each ->
        $socials = $ @
        $container = $socials.find settings.containerSelector
        if $container.length
          new SocialTw $container, settings
          new SocialFb $container, settings
          new SocialVk $container, settings
          new SocialGp $container, settings
          new SocialOk $container, settings

          if settings.isInitScroller
            initScroller $socials, $container

  initScroller = ($socials, $container) ->
    checkSocialScroll = ->
      if $(window).scrollTop() > offset
        $container.addClass 'float'
      else
        $container.removeClass 'float'

    offset = $socials.offset().top + $socials.height()

    $(document).on 'scroll', checkSocialScroll

    checkSocialScroll()

  $.fn.socialShareButtons = (method) ->
    if methods[method] then methods[method].apply @, Array::slice.call(arguments, 1)
    else if typeof method is "object" or not method then methods.init.apply @, arguments
    else $.error "Метод с именем #{method} не существует для jQuery.#{PLUGIN_NAME}"