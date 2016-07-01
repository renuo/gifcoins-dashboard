$ ->
  class Application
    constructor: ->
      activityData = $('#main').data('activities')

      activities = []
      for item in activityData['activities']
        activities.push new Activity(item)

      controller = new ActivityController(activities)
      showNext = () -> controller.showNext()
      setInterval(showNext, 30000)

  class ActivityController
    constructor: (activities) ->
      @elements = []
      @container = $('#main')
      $('.loading-message').hide()
      for activity in activities
        view = new ActivityView(activity)
        element = view.render()
        element.hide()
        @elements.push(element)

      @currentElement = @elements.shift()
      @container.append(@currentElement)
      @currentElement.show()

    showNext: () ->
      oldElement = @currentElement
      oldElement.slideUp(null, oldElement.detach)
      @elements.push(oldElement)
      @currentElement = @elements.shift()
      @container.append(@currentElement)
      @currentElement.slideDown()



  class ActivityView
    constructor: (@activity) ->

    render: () ->
      container = ViewHelper.createElement('div', 'activity')

      transactionContainer = ViewHelper.createElement('div', 'activity__transaction')
      container.append(transactionContainer)

      coinContainer = ViewHelper.createElement('div', 'activity__coins')
      transactionContainer.append(coinContainer)
      for i in [1..@activity.coins]
        coin = ViewHelper.createElement('img', 'activity__coin')
        coin.attr('src', 'img/coin.png')
        coinContainer.append(coin)

      recipientContainer = new UserView(@activity.recipient).render()
      transactionContainer.append(recipientContainer)


      commentContainer = ViewHelper.createElement('div', 'activity__comment')
      commentContainer.text(@activity.comment)
      container.append(commentContainer)

      donorContainer = new UserView(@activity.donor).render()
      donorContainer.addClass('user--donor')
      commentContainer.append(donorContainer)

      container


  class UserView
    constructor: (@user) ->

    render: () ->
      container = ViewHelper.createElement('div', 'user')

      avatarContainer = ViewHelper.createElement('img', 'user__avatar')
      avatarContainer.attr('src', @user.avatarUrl)
      container.append(avatarContainer)

      nameContainer = ViewHelper.createElement('div', 'user__name')
      nameContainer.text(@user.name)
      container.append(nameContainer)

      container


  class Activity
    constructor: (data) ->
      {
        payload: {
          coins: @coins,
          comment: @comment,
          recipient: recipient
        },
        user: donor
      } = data

      @donor = new User(donor)
      @recipient = new User(recipient)

  class User
    constructor: (data) ->
      {avatarUrl: @avatarUrl, name: @name} = data

  class ViewHelper
    @createElement: (element, cssClass) ->
      element = $(document.createElement(element))
      element.addClass(cssClass)
      element


  new Application()
