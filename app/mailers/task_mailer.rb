class TaskMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.task_mailer.new.subject
  #
  def some_new(task_id)
    task = Task.find(task_id)
    mail(to: "miguef7@gmail.com", subject: "Nuevo mike servicio-> #{task.user} necesita: #{task.description}" )
  end
end
