namespace :fotolotto do
  desc 'Updates the reveal type value'
  task update_reveal_type: :environment do
    Prize.where(reveal_type: 'lottery_end').update_all(reveal_type: 'drawing_end')
  end
end
