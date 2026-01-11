from typing import Annotated

import supabase_auth
from fastapi import Depends
from sqlmodel import select

from app.deps import SessionDep
from app.models.user import User, UserBase


class UserService:
    def __init__(self, session: SessionDep):
        self.session = session

    def create_user(self, supabase_user: supabase_auth.User) -> User:
        """ユーザーを作成"""
        user_base = UserBase.model_validate(supabase_user.user_metadata)
        user = User(
            id=supabase_user.id,
            nickname=user_base.name,
            **user_base.model_dump(),
        )

        self.session.add(user)
        self.session.commit()
        self.session.refresh(user)

        return user

    def get_user(self, user_id: str) -> User | None:
        """ユーザーを取得"""
        return self.session.get(User, user_id)

    def has_user(self, user_id: str) -> bool:
        """ユーザーが存在するか"""
        stmt = select(User.id).where(User.id == user_id).limit(1)
        return self.session.exec(stmt).first() is not None

    def has_username(self, name: str) -> bool:
        """ユーザー名が存在するか"""
        stmt = select(User.id).where(User.name == name).limit(1)
        return self.session.exec(stmt).first() is not None


UserServiceDep = Annotated[UserService, Depends(UserService)]
