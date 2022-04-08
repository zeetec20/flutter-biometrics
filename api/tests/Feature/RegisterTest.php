<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class RegisterTest extends TestCase
{
    use RefreshDatabase;

    public function test_failed_without_body()
    {
        $response = $this->post(route('register'));
        $response->assertStatus(400);
        $this->assertFalse($response->json()['success']);
        $this->assertArrayHasKey('success', $response->json());
        $this->assertArrayHasKey('message', $response->json());
        $this->assertArrayHasKey('data', $response->json());
    }

    public function test_success_register()
    {
        $user = User::factory()->make()->makeVisible('password')->toArray();
        $response = $this->post(route('register'), $user);
        $response->assertStatus(200);
        $response->assertJson([
            'success' => true
        ]);
    }
}
