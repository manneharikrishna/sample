shared_examples 'Drawing Statistics API' do
  it 'returns drawing statistics' do
    get path, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response['revenue']).to be_present
    expect(json_response['tickets']).to be_present
    expect(json_response['spending']).to be_present
    expect(json_response['payout']).to be_present

    expect(json_response['revenue']['total_turn_over']).to be_present
    expect(json_response['revenue']['gross_gaming_revenue']).to be_present

    expect(json_response['tickets']['players_count']).to be_present
    expect(json_response['tickets']['sold_tickets_count']).to be_present
    expect(json_response['tickets']['winning_tickets_count']).to be_present

    expect(json_response['spending']['lowest_spending']).to be_present
    expect(json_response['spending']['highest_spending']).to be_present
    expect(json_response['spending']['average_spending']).to be_present

    expect(json_response['payout']['total_prize_payout']).to be_present
    expect(json_response['payout']['total_prize_payout_ratio']).to be_present
    expect(json_response['payout']['prizes']).to be_present

    expect(json_response['payout']['prizes'][0]['name']).to be_present
    expect(json_response['payout']['prizes'][0]['prize_payout']).to be_present
    expect(json_response['payout']['prizes'][0]['prize_payout_ratio']).to be_present
  end
end
