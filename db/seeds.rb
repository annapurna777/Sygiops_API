# Role
SygiopsSupport::Role.find_or_create_by(name: "Admin", preferences: nil, default_create: false, active: true, note: nil)
SygiopsSupport::Role.find_or_create_by(name: "Agent", preferences: nil, default_create: true, active: true, note: nil)
SygiopsSupport::Role.find_or_create_by(name: "Customer", preferences: nil, default_create: false, active: true, note: nil)

#Ticket::State
SygiopsSupport::Ticket::State.find_or_create_by(name: "new", next_state_id: nil, ignore_escalation: false, default_create: true, default_follow_up: true, note: nil, active: true)
SygiopsSupport::Ticket::State.find_or_create_by(name: "open", next_state_id: nil, ignore_escalation: false, default_create: false, default_follow_up: false, note: nil, active: true)
SygiopsSupport::Ticket::State.find_or_create_by(name: "pending reminder", next_state_id: nil, ignore_escalation: false, default_create: false, default_follow_up: false, note: nil, active: true)
SygiopsSupport::Ticket::State.find_or_create_by(name: "closed", next_state_id: nil, ignore_escalation: false, default_create: false, default_follow_up: false, note: nil, active: true)
SygiopsSupport::Ticket::State.find_or_create_by(name: "merged", next_state_id: nil, ignore_escalation: false, default_create: false, default_follow_up: false, note: nil, active: true)
SygiopsSupport::Ticket::State.find_or_create_by(name: "removed", next_state_id: nil, ignore_escalation: false, default_create: false, default_follow_up: false, note: nil, active: true)

#Ticket::Priority
SygiopsSupport::Ticket::Priority.find_or_create_by(name: "1 low", default_create: false, ui_icon: "low-priority", ui_color: "low-priority", note: nil, active: true)
SygiopsSupport::Ticket::Priority.find_or_create_by(name: "2 normal", default_create: true, ui_icon: "normal-priority", ui_color: "normal-priority", note: nil, active: true)
SygiopsSupport::Ticket::Priority.find_or_create_by(name: "3 high", default_create: false, ui_icon: "important", ui_color: "high-priority", note: nil, active: true)

#Type
SygiopsSupport::Ticket::Type.find_or_create_by(name: "Incident" , default_create: false)
SygiopsSupport::Ticket::Type.find_or_create_by(name: "Request" , default_create: false)
SygiopsSupport::Ticket::Type.find_or_create_by(name: "Problem" , default_create: true)

#Group
SygiopsSupport::Group.find_or_create_by(name: "Users", assignment_timeout: nil, follow_up_possible: "yes", follow_up_assignment: true, active: true, note: "Standard Group/Pool for Tickets.")

#Ticket::Article::Type
SygiopsSupport::Ticket::Article::Type.find_or_create_by(name: "email", note: nil, communication: true, active: true)

#Ticket::Article::Sender
SygiopsSupport::Ticket::Article::Sender.find_or_create_by(name: "Agent", note: nil)
SygiopsSupport::Ticket::Article::Sender.find_or_create_by(name: "Customer", note: nil)
SygiopsSupport::Ticket::Article::Sender.find_or_create_by(name: "System", note: nil)

#scheduler
SygiopsSupport::Scheduler.find_or_create_by(
  name:          'Check Channels',
  method:        'Channel.fetch',
  period:        30.seconds,
  prio:          1,
  active:        true,
)
SygiopsSupport::Scheduler.find_or_create_by(
  name:          'Check Sla breaches',
  method:        'Ticket.notify_sla_breach',
  period:        60.seconds,
  prio:          1,
  active:        true,
)
SygiopsSupport::Scheduler.find_or_create_by(
  name:          'Send notification about creation of new ticket',
  method:        'Ticket.notify_ticket_created',
  period:        60.seconds,
  prio:          1,
  active:        true,
)
SygiopsSupport::Scheduler.find_or_create_by(
  name:          'Check streams for Channel',
  method:        'Channel.stream',
  period:        60.seconds,
  prio:          1,
  active:        true,
)

SygiopsSupport::Scheduler.find_or_create_by(
  name:          'Delete obsolete classic IMAP backup.',
  method:        'ImapAuthenticationMigrationCleanupJob.perform_now',
  period:        1.day,
  prio:          2,
  active:        true,

)

SygiopsSupport::User.find_or_create_by(
  login:         '-',
  firstname:     '-',
  lastname:      '',
  email:         '',
  active:        false,
  role_id:       SygiopsSupport::Role.find_by(name: "Agent").id
)

UserInfo.current_user_id = 1

#Signature
SygiopsSupport::Signature.find_or_create_by(
  name:          'default',
  body:          '
  #{user.firstname} #{user.lastname}

--
 Sygiops Support
 1237, Ithum Tower ,near Noida electronic city metro station
 Email: support@sygitech.com - Web: http://www.sygitech.com/
--'.text2html
)

#Calendar
SygiopsSupport::Calendar.find_or_create_by(name: "Default Calendar", timezone: nil, business_hours: {"mon"=>{"timeframes"=>[["09:00", "18:00"]], "active"=>"true"}, "tue"=>{"timeframes"=>[["09:00", "18:00"]], "active"=>"true"}, "wed"=>{"timeframes"=>[["09:00", "18:00"]], "active"=>"true"}, "thu"=>{"timeframes"=>[["09:00", "18:00"]], "active"=>"true"}, "fri"=>{"timeframes"=>[["09:00", "18:00"]], "active"=>"true"}, "sat"=>{"timeframes"=>[["09:00", "18:00"]], "active"=>"false"}, "sun"=>{"timeframes"=>[["09:00", "18:00"]], "active"=>"false"}}, default_create: true, ical_url: nil,public_holidays: {})

#Sla
SygiopsSupport::Sla.find_or_create_by(calendar_id: SygiopsSupport::Calendar.find_by(default_create: true).id, name: "Default Sla",first_response_time: 120,solution_time: 240 , default_create: true)
