package com.springboot.hobbyverse.service;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.config.CustomOAuth2User;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.model.UserActivity;
import com.springboot.hobbyverse.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
	private final UserRepository userRepository;
	private final UserActivityService userActivityService;
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) {
		OAuth2User oAuth2User = super.loadUser(userRequest);
		String provider = userRequest.getClientRegistration().getRegistrationId(); //제공자
		String providerId = oAuth2User.getAttribute("sub"); //구글은 "sub"이 고유 ID
		String email = oAuth2User.getAttribute("email");
		String name = oAuth2User.getAttribute("name");
		
		Optional<User> existingUser = userRepository.findByProviderAndProviderId(provider, providerId);
		User user;
		
		if(existingUser.isPresent()) {
			user = existingUser.get();
			user.update(name);
		}else {
			user = User.builder()
					.email(email)
					.name(name)
					.role("ROLE_USER")
					.provider(provider)
					.providerId(providerId)
					.build();
			userRepository.save(user);
			
			UserActivity newUserActivity = UserActivity.builder()
					.activityDate(LocalDate.now())
					.newUsers(1)
					.unsubscribedUsers(0)
					.joinedMeetings(0)
					.build();
			
			userActivityService.saveUserActivity(newUserActivity);
		}
		return new CustomOAuth2User(oAuth2User);
		
	}
	
	

}