<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class UseBiometricsTest extends TestCase
{
    use RefreshDatabase;

    public function test_failed_without_token()
    {
        $response = $this->post(route('biometrics'));
        $response->assertStatus(401);
    }

    public function test_success_change_biometrics()
    {
        $user = User::factory()->create();
        $responseLogin = $this->post(route('login'), [
            'email' => $user->email,
            'password' => 'admin123'
        ]);
        $response = $this->post(route('biometrics'), [], [
            'Authorization' => 'Bearer ' . $responseLogin->json()['data']['token']
        ]);
        $this->assertTrue(User::where('id', $user->id)->first()->use_biometrics == 1);
        $response->assertStatus(200);
        $response->assertJson([
            'success' => true
        ]);
    }
}
