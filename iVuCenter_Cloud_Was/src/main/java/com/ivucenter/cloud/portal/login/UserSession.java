package com.ivucenter.cloud.portal.login;

import java.util.Collection;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserSession implements UserDetails {

	private static final long serialVersionUID = -8859804450269958297L;
	Collection<? extends GrantedAuthority> authorities; // auth roles
	private String roles; 		// string role "1000000110000001"
	private String username; 	// user id
	private String password; 	// user password
	private String nickname;	 	// user korean name ex.홍길동
	private String pwdInitFlag; // Y: 배치에 의한 유저 생성, C: 패스워드 변경 90일 초과, N: 정상유저(패스워드 변경 시 N으로 설정)
	private String deptCode;
	private String customerId;
	private String levelCode;
	private String levelName;
	private String apprvPass;

	public String [] roleStr = {
			"ROLE_CLOUD_ADMIN", 			// 0  10000001 00000001 상품 승인자(1/2/3차 승인) (MNG 관리자 페이지)
			"ROLE_CLOUD_OPERATION", 		// 1  01000001 00000001 작업 담당
			"", 							// 2  00100001 00000001 작업 확인 							  // ROLE_CLOUD_CONFIRM_ACTION
			"", 							// 3  00010001 00000001 정산 승인 (신청자, 기획자, 회계자, 1/2차 승인) // ROLE_CLOUD_ACCT
			"",								// 4  00001001 00000001 프료젝트 승인                                                           // ROLE_CLOUD_PM
			"ROLE_CLOUD_ADMIN_USER",		// 5  00000101 00000001 회원 가입 승인
			"",								// 6  00000011 00000001
			"ROLE_CLOUD_USER", 				// 7  00000001 00000001 관리자 페이지 유저

			"ROLE_CUSTOM_ADMIN", 			// 8  00000000 10000001 상품 승인자 유저 (MBR 사용자 페이지)
			"",								// 9  00000000 01000001
			"",								// 10 00000000 00100001
			"", 							// 11 00000000 00010001 정산 요청 유저   						// ROLE_CUSTOM_ACCT
			"", 							// 12 00000000 00001001 프로젝트 요청 유저 						// ROLE_CUSTOM_PM
			"",								// 13 00000000 00000101
			"",								// 14 00000000 00000011
			"ROLE_CUSTOM_USER", 			// 15 00000000 00000001 사용자 페이지 유저
	};

	// Constructor
	public UserSession(Map<String, String> map) {
//	public UserSession(String id, String pwd, String roles, String nickname, String initFlag, String deptCode , String apprvPass) {

		this.roles = map.get("roles");
		if(null != this.roles) { this.authorities = convertAuthToSet(this.roles); }

		this.username 		= map.get("id");
		this.password 		= map.get("pwd");
		this.authorities 	= convertAuthToSet(roles);
		this.nickname 		= map.get("nickname");
		this.pwdInitFlag 	= map.get("initFlag");
		this.deptCode 		= map.get("deptCode");
		this.apprvPass 		= map.get("apprvPass");
		this.customerId = map.get("customerId");
		this.levelCode	= map.get("levelCode");
		this.levelName	= map.get("levelName");
	}

	private Set<GrantedAuthority> convertAuthToSet(String sRoles) {
		Set<GrantedAuthority> auth = new HashSet<GrantedAuthority>();
		for(int i = 0; i < sRoles.length(); i++) {
			if( (sRoles.charAt(i) == '1') && (roleStr[i].isEmpty() == false) ) {
				auth.add(new SimpleGrantedAuthority(roleStr[i]));
			}
		}
		return auth;
	}

	public boolean hasRole(String role) {
		return authorities.contains(new SimpleGrantedAuthority(role));
	}

	public boolean hasAnyRole(String ... roles) {
		boolean ret = false;

		for(String role : roles) {
			if(authorities.contains(new SimpleGrantedAuthority(role))) { ret = true; }
		}
		return ret;
	}

	@Override public boolean isAccountNonExpired() { return true; }
	@Override public boolean isAccountNonLocked() {	return true; }
	@Override public boolean isCredentialsNonExpired() { return true; }
	@Override public boolean isEnabled() { return true; }

}
